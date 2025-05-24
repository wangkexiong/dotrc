-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>cfg", ":e " .. vim.fn.stdpath("config") .. "<CR>", { noremap = true, silent = true })

if vim.g.neovide then
  vim.keymap.set(
    { "n", "v" },
    "<C-PageUp>",
    ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>",
    { noremap = true, silent = true }
  )
  vim.keymap.set(
    { "n", "v" },
    "<C-PageDown>",
    ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>",
    { noremap = true, silent = true }
  )
  vim.keymap.set({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { noremap = true, silent = true })
end
