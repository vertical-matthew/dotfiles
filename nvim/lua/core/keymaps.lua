-- Leader is set in options.lua
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })

-- Your habits
vim.keymap.set("n", "<CR>", ":nohlsearch<CR><CR>", { silent = true })
vim.keymap.set("i", "jk", "<Esc>", { silent = true })
vim.keymap.set("n", "qq", ":qa<CR>", { silent = true })
vim.keymap.set("n", "ww", ":wa<CR><CR>", { silent = true })
vim.keymap.set("n", "<C-s>", ":update<CR>", { silent = true })

-- Splits
vim.keymap.set("n", "<Leader><Leader>h", "<C-w>v", { silent = true })
vim.keymap.set("n", "<Leader><Leader>v", "<C-w>s", { silent = true })

-- Window nav
vim.keymap.set("n", "<leader>h", "<C-w>h", { silent = true })
vim.keymap.set("n", "<leader>j", "<C-w>j", { silent = true })
vim.keymap.set("n", "<leader>k", "<C-w>k", { silent = true })
vim.keymap.set("n", "<leader>l", "<C-w>l", { silent = true })

-- Indent and keep selection
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

-- Command mode
vim.keymap.set({ "n", "v" }, ";", ":", { noremap = true })

-- ===== Restored "old" navigation muscle memory =====

-- Shift+J / Shift+K (i.e. J/K) = paragraph jumps
-- (your old mapping: J -> } and K -> {)
vim.keymap.set("n", "J", "}", { silent = true })
vim.keymap.set("n", "K", "{", { silent = true })

-- Ctrl+j / Ctrl+k = screen jumps (half page)
vim.keymap.set("n", "<C-j>", "<C-d>", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-u>", { silent = true })

-- Jump list back/forward (you previously used H/L for this)
vim.keymap.set("n", "H", "<C-o>", { silent = true })
vim.keymap.set("n", "L", "<C-i>", { silent = true })

-- Your file start/end arrows
vim.keymap.set("n", "<Up>", "gg", { silent = true })
vim.keymap.set("n", "<Down>", "G", { silent = true })
