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

          map('n', '<leader>gc', function()
              gitsigns.blame_line({ full = true })
            end,
            { desc = 'Git show commit', }
          )

          -- Toggle between showing unstaged changes vs latest commit's changes
          local showing_last_commit = false
          map('n', '<leader>gd',
            function()
              if showing_last_commit then
                gitsigns.change_base(nil, true)
                showing_last_commit = false
                vim.notify('Gitsigns: showing unstaged changes', vim.log.levels.INFO)
              else
                gitsigns.change_base('HEAD~1', true)
                showing_last_commit = true
                vim.notify('Gitsigns: showing latest commit changes', vim.log.levels.INFO)
              end
            end,
            { desc = 'Git diff toggle (unstaged / latest commit)', }
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
