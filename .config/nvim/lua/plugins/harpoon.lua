return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({})

    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    vim.keymap.set("n", "<leader>ha",
      function() harpoon:list():add() end,
      { desc = "Harpoon add mark", }
    )
    vim.keymap.set("n", "<leader>hr",
      function() harpoon:list():remove() end,
      { desc = "Harpoon remove mark", }
    )
    vim.keymap.set("n", "[h",
      function() harpoon:list():prev({ ui_nav_wrap = true }) end,
      { desc = "Harpoon go to previous mark", }
    )
    vim.keymap.set("n", "]h",
      function() harpoon:list():next({ ui_nav_wrap = true }) end,
      { desc = "Harpoon go to next mark", }
    )
    vim.keymap.set("n", "<leader>hl",
      function() toggle_telescope(harpoon:list()) end,
      { desc = "Harpoon list marks", }
    )
  end,
}
