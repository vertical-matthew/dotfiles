-- init.lua

-- Reset runtimepath in case it got corrupted (fixes E5009)
pcall(vim.cmd, "set runtimepath&")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.autocmds")
require("core.keymaps")
require("core.lazy") -- ONLY place lazy.setup() happens
