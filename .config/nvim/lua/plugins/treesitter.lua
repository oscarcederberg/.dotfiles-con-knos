return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
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
        "markdown_inline",
        "meson",
        "query",
        "regex",
        "rust",
        "sql",
        "typescript",
        "vim",
        "vimdoc",
      })

      -- Enable higlighting
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          if vim.treesitter.get_parser(0, nil, { error = false }) then
            vim.treesitter.start()
          end
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
  },
}
