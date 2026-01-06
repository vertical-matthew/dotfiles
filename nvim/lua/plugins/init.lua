-- lua/plugins/init.lua
return {
  -- Icons: make non-optional (fixes barbar warning)
  { "nvim-tree/nvim-web-devicons", lazy = false, priority = 1000 },

  -- which-key (v3 spec)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>f", group = "+find" },
        { "<leader>o", group = "+oil" },
        { "<leader>l", group = "+lsp" },
        { "<leader>t", group = "+tools" },
        { "<leader>r", group = "+refactor" },
        { "<leader>m", group = "+move" },

        { "<leader>5", desc = "Oil" },
        { "<leader>6", desc = "UndoTree" },
        { "<leader>8", desc = "Symbols" },

        { "<leader>ff", desc = "Find files" },
        { "<leader>fg", desc = "Live grep" },
        { "<leader>fb", desc = "Buffers" },
        { "<leader>fh", desc = "Help tags" },
        { "<leader>fl", desc = "Fuzzy (buffer)" },
        { "<leader>//", desc = "Fuzzy (buffer)" },

        { "<leader>rn", desc = "Rename symbol" },
        { "<leader>dict", desc = "Dictionary" },
        { "<leader>thes", desc = "Thesaurus" },
      },
    },
  },

  { "nvim-lua/plenary.nvim" },

  -- Textobj framework + requested objects
  { "kana/vim-textobj-user", lazy = false },
  { "kana/vim-textobj-entire", lazy = false, dependencies = { "kana/vim-textobj-user" } },
  { "kana/vim-textobj-line", lazy = false, dependencies = { "kana/vim-textobj-user" } },
  { "michaeljsmith/vim-indent-object", lazy = false },
  { "bps/vim-textobj-python", ft = { "python" }, dependencies = { "kana/vim-textobj-user" } },

  -- Smarter f/F/t/T
  {
    "rhysd/clever-f.vim",
    lazy = false,
    init = function()
      vim.g.clever_f_fix_key_direction = 1
      vim.g.clever_f_mark_char = 1
    end,
  },

  -- Move lines/blocks (explicit Alt+hjkl, no Ctrl-j/Ctrl-k collision)
  {
    "matze/vim-move",
    lazy = false,
    init = function()
      vim.g.move_map_keys = 0
      vim.api.nvim_set_keymap("n", "<A-j>", "<Plug>MoveLineDown", {})
      vim.api.nvim_set_keymap("n", "<A-k>", "<Plug>MoveLineUp", {})
      vim.api.nvim_set_keymap("n", "<A-h>", "<Plug>MoveLineLeft", {})
      vim.api.nvim_set_keymap("n", "<A-l>", "<Plug>MoveLineRight", {})

      vim.api.nvim_set_keymap("v", "<A-j>", "<Plug>MoveBlockDown", {})
      vim.api.nvim_set_keymap("v", "<A-k>", "<Plug>MoveBlockUp", {})
      vim.api.nvim_set_keymap("v", "<A-h>", "<Plug>MoveBlockLeft", {})
      vim.api.nvim_set_keymap("v", "<A-l>", "<Plug>MoveBlockRight", {})
    end,
  },

  -- Oil
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { silent = true })
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
      vim.keymap.set("n", "<leader>//", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { silent = true })
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

  -- Barbar (depends on devicons)
  {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      icons = { filetype = { enabled = true } },
    },
    config = function()
      vim.keymap.set("n", "<Left>", ":BufferPrevious<CR>", { silent = true })
      vim.keymap.set("n", "<Right>", ":BufferNext<CR>", { silent = true })
    end,
  },

  { "lewis6991/gitsigns.nvim", opts = {} },

  -- Treesitter: DO NOT load during headless sync; only on edit or TS commands
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdate", "TSInstall", "TSUninstall", "TSModuleInfo", "TSBufEnable", "TSBufDisable" },
    build = ":TSUpdate",
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

  -- LSP + completion (Neovim 0.11+)
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
          vim.keymap.set("n", "gK", vim.lsp.buf.hover, opts) -- K is paragraph jump
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

  -- Hop (keep mappings)
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

  -- Gruvbox
  {
    "morhetz/gruvbox",
    config = function()
      vim.o.background = "dark"
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
