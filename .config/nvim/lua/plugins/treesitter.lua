return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {
            "asm",
            "c",
            "csv",
            "dockerfile",
            "go",
            "html",
            "javascript",
            "json",
            "lua",
            "make",
            "markdown",
            "meson",
            "query",
            "regex",
            "rust",
            "sql",
            "typescript",
            "vim",
            "vimdoc",
          },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = false },
        })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
  },
}
