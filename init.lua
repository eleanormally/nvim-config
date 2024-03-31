vim.o.guifont = "ComicShannsMono Nerd Font Mono:h14"
vim.g.mapleader = " "

-- sync clipboard to system
vim.opt.clipboard = "unnamedplus"

-- install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

require("plugins")
require("config")
