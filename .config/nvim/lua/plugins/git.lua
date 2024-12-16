return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c',
            function()
              if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
              else
                gitsigns.nav_hunk('next')
              end
            end,
            { desc = 'Git next hunk', }
          )

          map('n', '[c',
            function()
              if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
              else
                gitsigns.nav_hunk('prev')
              end
            end,
            { desc = 'Git previous hunk', }
          )
        end,
      }
    end,
  },
  {
    'FabijanZulj/blame.nvim',
    lazy = false,
    config = function()
      require('blame').setup {}
      vim.keymap.set('n', '<leader>gb', '<cmd>BlameToggle virtual<cr>',
        { desc = 'Blame toggle', }
      )
    end,
  },
}
