-- nvim/lua/core/autocmds.lua
local api = vim.api

-- Highlight yanks (built-in)
api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Search highlight styling (applies after colorscheme loads)
api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    api.nvim_set_hl(0, "Search", { fg = "grey", bg = "NONE" })
    api.nvim_set_hl(0, "IncSearch", { fg = "white", bg = "blue", bold = true })
  end,
})
