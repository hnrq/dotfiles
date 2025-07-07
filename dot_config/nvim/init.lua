---------------------------------------
-- Early leader key setup
---------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

---------------------------------------
-- Bootstrap lazy.nvim package manager
---------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

---------------------------------------
-- Initialize plugin manager
---------------------------------------
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
})

---------------------------------------
-- Load core configurations
---------------------------------------
-- Core editor options
require("config.options")
-- Keymaps
require("config.keymaps")
-- Auto commands
require("config.autocmds")
