-- nvim/lua/core/options.lua
local fn = vim.fn
local opt = vim.opt

-- Persistent undo/backup/swap (cross-platform, keeps your intent)
local state = fn.stdpath("state")
local undodir = state .. "/undo"
local backupdir = state .. "/backup"
local swapdir = state .. "/swap"

fn.mkdir(undodir, "p")
fn.mkdir(backupdir, "p")
fn.mkdir(swapdir, "p")

opt.history = 1000
opt.undolevels = 5000

opt.backup = true
opt.writebackup = true
opt.backupcopy = "yes"
opt.backupdir = backupdir .. "//"

opt.swapfile = true
opt.directory = swapdir .. "//"

opt.undofile = true
opt.undodir = undodir

opt.updatetime = 1000
opt.autowrite = true
opt.confirm = true
opt.shortmess:append("A")

opt.termguicolors = true
opt.background = "dark"

opt.backspace = { "indent", "eol", "start" }
opt.clipboard = "unnamedplus"

opt.number = true
opt.relativenumber = true
opt.ruler = true
opt.scrolloff = 10
opt.laststatus = 2

opt.colorcolumn = "80"
opt.signcolumn = "yes"
opt.mouse = "a"

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftround = false

opt.wrap = false
opt.textwidth = 0
opt.wrapmargin = 0

opt.foldlevel = 99
opt.foldenable = true

opt.hidden = true
opt.encoding = "utf-8"

opt.timeout = true
opt.timeoutlen = 1000
opt.ttimeoutlen = 100

opt.visualbell = true

opt.spell = true
opt.spelllang = { "en_us" }

opt.listchars = {
  eol = "¬",
  tab = ">·",
  trail = "~",
  extends = ">",
  precedes = "<",
  space = "␣",
}
-- matches your old config: define listchars but don't force list=on
opt.list = false

opt.splitright = true
opt.splitbelow = true

-- Your old intent: don't auto-wrap text while typing
opt.formatoptions = "tcqrn1"
opt.formatoptions:remove("t")
