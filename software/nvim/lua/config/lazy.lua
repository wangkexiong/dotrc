local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local function load_external_plugins(dir)
  local plugins = {}

  local full_dir = vim.fn.expand(dir)
  if vim.fn.isdirectory(full_dir) == 1 then
    local files = vim.fn.glob(full_dir .. "/*.lua", false, true)
    for _, file in ipairs(files) do
      local ok, plugin = pcall(dofile, file)
      if ok and type(plugin) == "table" then
        table.insert(plugins, plugin)
      else
        vim.notify("Failed to load plugin from " .. file, vim.log.levels.WARN)
      end
    end
  end
  return plugins
end

local os_type = vim.loop.os_uname().sysname
local plugin_path = ""
if os_type == "Windows_NT" then
  local nvim_path = vim.fn.exepath("nvim")
  local nvim_bin_dir = vim.fn.fnamemodify(nvim_path, ":h")
  local nvim_root_dir = vim.fn.fnamemodify(nvim_bin_dir, ":h")
  plugin_path = nvim_root_dir .. "/conf"
elseif os_type == "Linux" then
  plugin_path = "~/.config/customized/nvim"
end
local customized_plugins = load_external_plugins(plugin_path)

local plugin_spec = {
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  { import = "plugins" },
}
if #customized_plugins > 0 then
  vim.list_extend(plugin_spec, customized_plugins)
end

require("lazy").setup({
  spec = plugin_spec,
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
