-- init.lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.autocmds")
require("core.keymaps")
require("core.lazy") -- the ONLY place lazy.nvim setup is invoked
