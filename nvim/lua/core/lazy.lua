-- lua/core/lazy.lua
local fn = vim.fn
local uv = vim.uv or vim.loop

-- Prevent double-setup (this is what triggers the "re-sourcing not supported" message)
if vim.g.__dotfiles_lazy_setup_done then
  return
end
vim.g.__dotfiles_lazy_setup_done = true

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not uv.fs_stat(lazypath) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(require("plugins"), {
  rocks = { enabled = false }, -- remove hererocks/luarocks noise
  change_detection = { enabled = false, notify = false },
  checker = { enabled = false },
})
