vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true

vim.o.updatetime = 1000
vim.o.scrolloff = 10
vim.o.wrap = false

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.completeopt = "menu,menuone,noselect"
vim.o.confirm = true

-- Persistent undo/backup/swap (portable, correct locations)
local function ensure_dir(p)
  if vim.fn.isdirectory(p) == 0 then
    vim.fn.mkdir(p, "p")
  end
end

local state = vim.fn.stdpath("state")
local undo = state .. "/undo"
local backup = state .. "/backup"
local swap = state .. "/swap"

ensure_dir(undo)
ensure_dir(backup)
ensure_dir(swap)

vim.o.undofile = true
vim.o.undodir = undo

vim.o.backup = true
vim.o.backupdir = backup .. "//"
vim.o.writebackup = true

vim.o.directory = swap .. "//"

