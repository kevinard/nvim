return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>s<CR>", require("telescope.builtin").resume, desc = "Resume previous [S]earch<CR>" },
    },
    opts = {
      defaults = {
        -- vimgrep_arguments = {
        --   "rg",
        --   "--color=never",
        --   "--no-heading",
        --   "--with-filename",
        --   "--line-number",
        --   "--column",
        --   "--smart-case",
        --   "--hidden",
        --   "--trim",
        --   "--glob",
        --   "!**/.git/*",
        -- },
        prompt_prefix = "   ",
        -- selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_ignore_patterns = { "node_modules" },
        path_display = { "truncate" },
        winblend = 0,
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
          },
        },
      },
      -- pickers = {
      --   find_files = {
      --     -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
      --     find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      --   },
      -- },
    },
  },
  -- {
  --   'sindrets/diffview.nvim',
  --   dependencies = 'nvim-lua/plenary.nvim',
  --   keys = {
  --     { "<leader>gd", "<cmd> DiffviewOpen <CR>" },
  --     { "<leader>gc", "<cmd> DiffviewClose <CR>" },
  --     { "<leader>gh", "<cmd> DiffviewFileHistory % <CR>" },
  --   },
  --   opts = {
  --     enhanced_diff_hl = true,
  --     view = {
  --       merge_tool = {
  --         layout = "diff3_mixed",
  --       },
  --     },
  --     hooks = {
  --       diff_buf_read = function(bufnr)
  --         -- Change local options in diff buffers
  --         vim.opt_local.wrap = false
  --         vim.opt_local.list = false
  --         vim.opt_local.colorcolumn = { 80 }
  --       end,
  --     }
  --   },
  -- },
}
