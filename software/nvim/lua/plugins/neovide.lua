-- stylua: ignore
if true then return {} end

--[[
  configuration for neovide in lazy mode.
  however, keymap can be set in config/keymaps directly.
--]]
return {
  {
    "LazyVim/LazyVim",
    opts = function()
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
        vim.keymap.set(
          { "n", "v" },
          "<C-0>",
          ":lua vim.g.neovide_scale_factor = 1<CR>",
          { noremap = true, silent = true }
        )
      end
    end,
  },
}
