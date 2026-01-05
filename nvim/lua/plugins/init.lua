-- =========================
-- lazy.nvim bootstrap
-- =========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if vim.loop.fs_stat(lazypath) == nil then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Helper: open URL cross-platform
local function open_url(url)
  local sys = vim.loop.os_uname().sysname
  if sys == "Windows_NT" then
    vim.fn.jobstart({ "cmd.exe", "/C", "start", "", url }, { detach = true })
  elseif sys == "Darwin" then
    vim.fn.jobstart({ "open", url }, { detach = true })
  else
    vim.fn.jobstart({ "xdg-open", url }, { detach = true })
  end
end

require("lazy").setup({
  { "nvim-lua/plenary.nvim" },

  -- =========================
  -- Text objects: `ae` / `ie`
  -- IMPORTANT: entire depends on user.
  -- =========================
  { "kana/vim-textobj-user", lazy = false },
  {
    "kana/vim-textobj-entire",
    lazy = false,
    dependencies = { "kana/vim-textobj-user" },
  },

  -- File browser
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      vim.keymap.set("n", "<F5>", "<CMD>Oil<CR>", { silent = true })
      vim.keymap.set("n", "<leader>5", "<CMD>Oil<CR>", { silent = true })
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
      vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { silent = true })
      vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { silent = true })
      vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { silent = true })
      vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { silent = true })
      vim.keymap.set("n", "<leader>fl", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { silent = true })
      vim.keymap.set("n", "?", "<cmd>Telescope live_grep<cr>", { silent = true })
    end,
  },

  -- UndoTree
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<F6>", ":UndotreeToggle<CR>", { silent = true })
      vim.keymap.set("n", "<leader>6", ":UndotreeToggle<CR>", { silent = true })
    end,
  },

  -- Buffer tabs
  {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {},
    config = function()
      vim.keymap.set("n", "<Left>", ":BufferPrevious<CR>", { silent = true })
      vim.keymap.set("n", "<Right>", ":BufferNext<CR>", { silent = true })
    end,
  },

  -- Git gutter
  { "lewis6991/gitsigns.nvim", opts = {} },

  -- Treesitter (loads when you run TS* commands)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cmd = { "TSUpdate", "TSInstall", "TSUninstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        return
      end
      configs.setup({
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- LSP + completion (Neovim 0.11+ API; no require('lspconfig'))
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
      })

      local caps = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config("pyright", { capabilities = caps })
      vim.lsp.enable("pyright")

      local grp = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = grp,
        callback = function(args)
          local opts = { buffer = args.buf, silent = true }

          -- K is paragraph-jump in your keymaps now; use gK for hover
          vim.keymap.set("n", "gK", vim.lsp.buf.hover, opts)

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)
        end,
      })

      vim.keymap.set("n", "<F8>", "<cmd>Telescope lsp_document_symbols<cr>", { silent = true })
      vim.keymap.set("n", "<leader>8", "<cmd>Telescope lsp_document_symbols<cr>", { silent = true })
    end,
  },

  -- Jump fast
  {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("hop").setup()
      vim.keymap.set("n", "<Leader>w", ":HopWord<CR>", { silent = true })
      vim.keymap.set("n", "<Leader>a", ":HopLine<CR>", { silent = true })
      vim.keymap.set("n", "<Leader><Leader>/", ":HopPattern<CR>", { silent = true })
    end,
  },

  -- Theme
  {
    "morhetz/gruvbox",
    config = function()
      vim.o.background = "dark"
      vim.cmd("colorscheme gruvbox")
    end,
  },
})

-- Dictionary / thesaurus
vim.keymap.set("n", "<leader>dict", function()
  open_url("https://www.dictionary.com/browse/" .. vim.fn.expand("<cword>"))
end, { silent = true })

vim.keymap.set("n", "<leader>thes", function()
  open_url("https://www.thesaurus.com/browse/" .. vim.fn.expand("<cword>"))
end, { silent = true })
