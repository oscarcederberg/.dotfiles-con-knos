vim.keymap.set("n", "]g", function()
  vim.diagnostic.jump({ count = 1, float = true })
end)
vim.keymap.set("n", "[g", function()
  vim.diagnostic.jump({ count = -1, float = true })
end)

vim.keymap.set("n", "<leader>us", function()
  vim.opt.spell = not vim.opt.spell:get()
  print("Spell: " .. (vim.opt.spell:get() and "ON" or "OFF"))
end, {
  desc = "Toggle spell checking",
})
