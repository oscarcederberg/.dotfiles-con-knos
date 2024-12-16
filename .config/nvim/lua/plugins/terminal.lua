return {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {},
  config = function()
    require("toggleterm").setup {}

    vim.keymap.set('n', '<leader>t',
      '<cmd>ToggleTerm size=24 direction=float name=term<cr>',
      { desc = 'Toggle floating terminal' })
    vim.keymap.set('t', '<leader>t', '<C-\\><C-n>',
      { desc = 'Toggle floating terminal' })
  end,
}
