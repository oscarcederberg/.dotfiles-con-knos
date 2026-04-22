return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = {
    'echasnovski/mini.icons',
  },
  config = function()
    require('oil').setup({
      default_file_explorer = true,
      columns = { 'icon' },
      float = {
        border = 'rounded',
      },
    })

    vim.keymap.set('n', '<leader>fe', function()
      require('oil').open_float()
    end, { desc = 'Open file explorer' })
  end,
}
