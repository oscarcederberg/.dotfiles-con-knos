vim.keymap.set("n", "]g", function() vim.diagnostic.jump({ count = 1, float = true }) end)
vim.keymap.set("n", "[g", function() vim.diagnostic.jump({ count = -1, float = true }) end)
