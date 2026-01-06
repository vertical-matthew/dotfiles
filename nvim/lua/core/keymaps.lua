-- lua/core/keymaps.lua
local map = vim.keymap.set
local silent = { silent = true }

map({ "n", "v" }, "<Space>", "<Nop>", silent)

map("n", "qq", "<cmd>qa<cr>", silent)
map("n", "<leader>qq", "<cmd>qa!<cr>", silent)
map("n", "ww", "<cmd>wa<cr><cr>", silent)
map("n", "<C-s>", "<cmd>update<cr>", silent)
map("i", "jk", "<Esc>", silent)
map("n", "q", "<cmd>q<cr>", silent)

map("n", "<leader><leader>h", "<C-w>v", silent)
map("n", "<leader><leader>v", "<C-w>s", silent)

map("v", "<", "<gv", silent)
map("v", ">", ">gv", silent)

map("n", ";", ":", { noremap = true })
map("v", ";", ":", { noremap = true })

map("n", "<CR>", "<cmd>nohlsearch<cr><cr>", silent)
map("n", "<leader>x", "<cmd>b#<cr>", silent)

map("n", "<leader>h", "<C-w>h", silent)
map("n", "<leader>j", "<C-w>j", silent)
map("n", "<leader>k", "<C-w>k", silent)
map("n", "<leader>l", "<C-w>l", silent)

-- Paragraph jumps
map({ "n", "v", "o" }, "J", "}", silent)
map({ "n", "v", "o" }, "K", "{", silent)

-- FIXED jump-list direction:
-- Ctrl+j = forward, Ctrl+k = back
map("n", "<C-j>", "<C-d>", silent)
map("n", "<C-k>", "<C-u>", silent)

map("n", "H", "<C-o>", silent)
map("n", "L", "<C-i>", silent)

map("n", "<C-h>", "^", silent)
map("n", "<C-l>", "$", silent)

map("n", "<Up>", "gg", silent)
map("n", "<Down>", "G", silent)

map("n", "Y", "y$", silent)

map("n", "<leader><leader>c", "zM", silent)
map("n", "<leader><leader>o", "zR", silent)

map("n", "<leader>-", "<cmd>g/^$/d<cr>", silent)
map("n", "<leader>vi", "<cmd>tabedit $MYVIMRC<cr>", silent)
map("n", "<leader><leader>t", "<cmd>terminal<cr>", silent)

map("n", "<BS>", "u", silent)
map("n", "<S-BS>", "<C-r>", silent)
