return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    lazy = true,
    config = false,
  },
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
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      local lsp_zero = require('lsp-zero')

      -- lsp_attach is where you enable features that only work
      -- if there is a language server active in the file
      local lsp_attach = function(client, bufnr)
        local opts = { buffer = bufnr }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>',
          { desc = "Hover information", unpack(opts) })
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>',
          { desc = "Go to definition", unpack(opts) })
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>',
          { desc = "Go to declaration", unpack(opts) })
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>',
          { desc = "List implementation", unpack(opts) })
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>',
          { desc = "Go to type definition", unpack(opts) })
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>',
          { desc = "List references", unpack(opts) })
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>',
          { desc = "Display signature help", unpack(opts) })
        vim.keymap.set('n', 'gh', '<cmd>ClangdSwitchSourceHeader<cr>',
          { desc = "Clangd switch between header and source", unpack(opts) })
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>',
          { desc = "Rename symbol", unpack(opts) })
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
          { desc = "Format code", unpack(opts) })
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>',
          { desc = "Select code action", unpack(opts) })
      end

      lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = lsp_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      })

      lsp_zero.setup_servers({
        'clangd',
        'gopls',
        'lua_ls',
        'marksman',
        'pylsp',
        'rust_analyzer',
      })

      lsp_zero.format_on_save({
        format_opts = {
          async = false,
          timeout_ms = 10000,
        },
        servers = {
          ['gopls'] = { 'go' },
          ['lua_ls'] = { 'lua' },
          ['rust_analyzer'] = { 'rust' },
        }
      })

      require('mason').setup({})
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
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
        }
      })
    end
  }
}
