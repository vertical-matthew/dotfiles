-- lua/plugins/init.lua
return {
  -- Icons (non-optional; barbar needs it)
  { "nvim-tree/nvim-web-devicons", lazy = false, priority = 1000 },

  -- which-key (v3 format)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>f", group = "+find" },
        { "<leader>o", group = "+oil" },
        { "<leader>l", group = "+lsp" },
        { "<leader>t", group = "+tools" },

        { "<leader>5", desc = "Oil" },
        { "<leader>6", desc = "UndoTree" },

        { "<leader>ff", desc = "Find files" },
        { "<leader>fg", desc = "Live grep" },
        { "<leader>fb", desc = "Buffers" },
        { "<leader>fh", desc = "Help tags" },
        { "<leader>fl", desc = "Fuzzy (buffer)" },
        { "?", desc = "Live grep" },
      },
    },
  },

  { "nvim-lua/plenary.nvim" },

  -- Text objects (your requested set)
  { "kana/vim-textobj-user", lazy = false },
  { "kana/vim-textobj-entire", lazy = false, dependencies = { "kana/vim-textobj-user" } },
  { "kana/vim-textobj-line", lazy = false, dependencies = { "kana/vim-textobj-user" } },
  { "michaeljsmith/vim-indent-object", lazy = false },
  { "bps/vim-textobj-python", ft = { "python" }, dependencies = { "kana/vim-textobj-user" } },

  -- clever-f
  { "rhysd/clever-f.vim", event = "VeryLazy" },

  -- vim-move (no default keymaps; keep it but don’t collide with Ctrl-j/k)
  {
    "matze/vim-move",
    event = "VeryLazy",
    init = function()
      vim.g.move_map_keys = 0
    end,
  },

  -- Oil
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "-", "<cmd>Oil<cr>", { silent = true })
      vim.keymap.set("n", "<F5>", "<cmd>Oil<cr>", { silent = true })
      vim.keymap.set("n", "<leader>5", "<cmd>Oil<cr>", { silent = true })
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
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

  -- Barbar (tabs)
  {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    config = function()
      vim.keymap.set("n", "<Left>", ":BufferPrevious<CR>", { silent = true })
      vim.keymap.set("n", "<Right>", ":BufferNext<CR>", { silent = true })
    end,
  },

  -- Git signs
  { "lewis6991/gitsigns.nvim", opts = {} },

  -- Treesitter: safe config (no crash if module missing)
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
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

  -- LSP + completion (Neovim 0.11+ style, minimal)
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

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf, silent = true }
          vim.keymap.set("n", "gK", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)
        end,
      })
    end,
  },

  -- Hop (FIX: use maintained fork to avoid broken healthcheck)
  {
    "smoka7/hop.nvim",
    version = "*",
    config = function()
      require("hop").setup()
      vim.keymap.set("n", "<leader>w", "<cmd>HopWord<cr>", { silent = true })
      vim.keymap.set("n", "<leader>a", "<cmd>HopLine<cr>", { silent = true })
      vim.keymap.set("n", "<leader><leader>/", "<cmd>HopPattern<cr>", { silent = true })
    end,
  },

  -- Gruvbox (keep)
  {
    "morhetz/gruvbox",
    config = function()
      vim.o.background = "dark"
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
