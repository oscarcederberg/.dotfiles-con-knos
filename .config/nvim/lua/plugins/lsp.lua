return {
  -- LSP Installer
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
        }),
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
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

      -- Mason
      require('mason').setup()

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require('mason-lspconfig').setup({
        ensure_installed = {
          'clangd',
          'gopls',
          'lua_ls',
          'marksman',
          'pylsp',
          'rust_analyzer',
        },
        handlers = {
          -- Default handler for all installed servers
          function(server_name)
            vim.lsp.config(server_name, {
              capabilities = capabilities,
              flags = { debounce_text_changes = 150 },
              settings = {}, -- optional per-server settings
            })
            vim.lsp.enable({ server_name })
          end,
        },
      })

      -- Format-on-save
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(event)
          local bufnr = event.buf
          local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
          local allowed = { go = true, lua = true, rust = true }

          if not allowed[ft] then return end

          local clients = vim.lsp.get_clients({ bufnr = bufnr })
          for _, client in ipairs(clients) do
            if client.supports_method("textDocument/formatting") then
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
