-- lua/core/keymaps.lua
local map = vim.keymap.set
local silent = { silent = true }

map({ "n", "v" }, "<Space>", "<Nop>", silent)

-- Save/Quit
map("n", "ww", "<cmd>wa<cr><cr>", silent)
map("n", "<C-s>", "<cmd>update<cr>", silent)
map("n", "qq", "<cmd>qa<cr>", silent)
map("n", "q", "<cmd>q<cr>", silent)

-- Insert escape
map("i", "jk", "<Esc>", silent)

-- Clear search highlight
map("n", "<CR>", "<cmd>nohlsearch<cr><cr>", silent)

-- Command mode on ;
map("n", ";", ":", { noremap = true })
map("v", ";", ":", { noremap = true })

-- Splits
map("n", "<leader><leader>h", "<C-w>v", silent)
map("n", "<leader><leader>v", "<C-w>s", silent)

-- Window nav
map("n", "<leader>h", "<C-w>h", silent)
map("n", "<leader>j", "<C-w>j", silent)
map("n", "<leader>k", "<C-w>k", silent)
map("n", "<leader>l", "<C-w>l", silent)

-- Visual indent keep selection
map("v", "<", "<gv", silent)
map("v", ">", ">gv", silent)

-- Paragraph jumps (your muscle memory)
map({ "n", "v", "o" }, "J", "}", silent)
map({ "n", "v", "o" }, "K", "{", silent)

-- Better Ctrl-j/k: half-page scroll (recommended)
map("n", "<C-j>", "<C-d>", silent)
map("n", "<C-k>", "<C-u>", silent)

-- Jump list back/forward (keep these)
map("n", "H", "<C-o>", silent)
map("n", "L", "<C-i>", silent)

-- File top/bottom arrows
map("n", "<Up>", "gg", silent)
map("n", "<Down>", "G", silent)

-- Better Y
map("n", "Y", "y$", silent)
