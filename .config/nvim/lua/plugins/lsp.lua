local servers = {
  'clangd',
  'gopls',
  'lua_ls',
  'marksman',
  'pylsp',
  'rust_analyzer',
}

return {
  {
    -- LSP Installer
    'mason-org/mason.nvim',
    lazy = false,
    config = true,
  },
  {
    -- Autocompletion
    'saghen/blink.cmp',
    dependencies = {
      'ribru17/blink-cmp-spell'
    },
    version = '1.*',
    opts = {
      keymap = {
        preset = 'default',
        ['<CR>'] = { 'select_and_accept', 'fallback' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
      },
      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'buffer',
          'spell'
        },
        providers = {
          spell = {
            name = 'Spell',
            module = 'blink-cmp-spell',
            opts = {
              -- EXAMPLE: Only enable source in `@spell` captures, and disable it
              -- in `@nospell` captures.
              enable_in_context = function()
                local curpos = vim.api.nvim_win_get_cursor(0)
                local captures = vim.treesitter.get_captures_at_pos(
                  0,
                  curpos[1] - 1,
                  curpos[2] - 1
                )
                local in_spell_capture = false
                for _, cap in ipairs(captures) do
                  if cap.capture == 'spell' then
                    in_spell_capture = true
                  elseif cap.capture == 'nospell' then
                    return false
                  end
                end
                return in_spell_capture
              end,
            },
          },
        },
      },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },
      fuzzy = {
        implementation = 'prefer_rust_with_warning',
        sorts = {
          function(a, b)
            local sort = require('blink.cmp.fuzzy.sort')

            if a.source_id == 'spell' and b.source_id == 'spell' then
              return sort.label(a, b)
            end
          end,

          'score',
          'kind',
          'label',
        },
      },
    },
  },
  {
    -- Auto-install LSP servers via Mason (enabling is handled explicitly below)
    'mason-org/mason-lspconfig.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      ensure_installed = servers,
      automatic_enable = false,
    },
  },
  {
    -- LSP
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'saghen/blink.cmp' },
      { 'mason-org/mason-lspconfig.nvim' },
    },
    config = function()
      -- Keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local opts = { buffer = bufnr }

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = "Hover information", unpack(opts) })
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = "Go to definition", unpack(opts) })
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>',
            { desc = "Go to declaration", unpack(opts) })
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>',
            { desc = "List implementation", unpack(opts) })
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>',
            { desc = "Go to type definition", unpack(opts) })
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = "List references", unpack(opts) })
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>',
            { desc = "Display signature help", unpack(opts) })
          vim.keymap.set('n', 'gh', '<cmd>ClangdSwitchSourceHeader<cr>',
            { desc = "Clangd: switch header/source", unpack(opts) })
          vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = "Rename symbol", unpack(opts) })
          vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
            { desc = "Format code", unpack(opts) })
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>',
            { desc = "Select code action", unpack(opts) })
        end,
      })

      -- Capabilities
      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      })

      -- Enable servers
      vim.lsp.enable(servers)

      -- Format-on-save
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(event)
          local bufnr = event.buf
          local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
          local allowed = { go = true, lua = true, rust = true }

          if not allowed[ft] then return end

          local clients = vim.lsp.get_clients({ bufnr = bufnr })
          for _, client in ipairs(clients) do
            if client:supports_method("textDocument/formatting") then
              vim.lsp.buf.format({
                async = false,
                timeout_ms = 10000,
                bufnr = bufnr,
              })
              return
            end
          end
        end,
      })
    end
  }
}
