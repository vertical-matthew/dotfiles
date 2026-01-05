vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "<CR>", ":nohlsearch<CR><CR>", { silent = true })
vim.keymap.set("i", "jk", "<Esc>", { silent = true })
vim.keymap.set("n", "qq", ":qa<CR>", { silent = true })
vim.keymap.set("n", "ww", ":wa<CR><CR>", { silent = true })
vim.keymap.set("n", "<C-s>", ":update<CR>", { silent = true })

vim.keymap.set("n", "<Leader><Leader>h", "<C-w>v", { silent = true })
vim.keymap.set("n", "<Leader><Leader>v", "<C-w>s", { silent = true })

vim.keymap.set("n", "<leader>h", "<C-w>h", { silent = true })
vim.keymap.set("n", "<leader>j", "<C-w>j", { silent = true })
vim.keymap.set("n", "<leader>k", "<C-w>k", { silent = true })
vim.keymap.set("n", "<leader>l", "<C-w>l", { silent = true })

vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

vim.keymap.set({ "n", "v" }, ";", ":", { noremap = true })

vim.keymap.set("n", "<Up>", "gg", { silent = true })
vim.keymap.set("n", "<Down>", "G", { silent = true })
