return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>ff', builtin.find_files, {
        desc = 'Telescope find files',
      })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {
        desc = 'Telescope live grep',
      })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {
        desc = 'Telescope buffers',
      })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {
        desc = 'Telescope help tags',
      })
      vim.keymap.set("n", "<leader>xx", builtin.diagnostics, {
        desc = "Diagnostics (Telescope)"
      })
      vim.keymap.set("n", "<leader>xX", function()
        builtin.diagnostics({ bufnr = 0 })
      end, { desc = "Buffer Diagnostics (Telescope)" })
      vim.keymap.set("n", "<leader>cs", builtin.lsp_document_symbols, {
        desc = "Document Symbols (Telescope)"
      })
      vim.keymap.set("n", "<leader>cl", builtin.lsp_definitions, {
        desc = "LSP Definitions (Telescope)"
      })
      vim.keymap.set("n", "<leader>cr", builtin.lsp_references, {
        desc = "LSP References (Telescope)"
      })
      vim.keymap.set("n", "<leader>xL", builtin.loclist, {
        desc = "Location List (Telescope)"
      })
      vim.keymap.set("n", "<leader>xQ", builtin.quickfix, {
        desc = "Quickfix List (Telescope)"
      })
    end,
  },
}
