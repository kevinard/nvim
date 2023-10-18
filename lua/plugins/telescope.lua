return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      {
        "folke/trouble.nvim",
        opts = {
          padding = false,
          use_diagnostic_signs = true,
          action_keys = {
            open_split = { "\\" }, -- open buffer in new split
            open_vsplit = { "|" }, -- open buffer in new vsplit
          },
        },
      },
      { "debugloop/telescope-undo.nvim" },
    },
    init = function ()
      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'undo')

      -- See `:help telescope.builtin`
      vim.keymap.set('n', '<leader>?', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer]' })

      vim.keymap.set('n', '<leader>sg', function()
        local function is_git_repo()
          vim.fn.system("git rev-parse --is-inside-work-tree")
          return vim.v.shell_error == 0
        end

        local function get_git_root()
          local dot_git_path = vim.fn.finddir(".git", ".;")
          return vim.fn.fnamemodify(dot_git_path, ":h")
        end

        local opts = {}

        if is_git_repo() then
          opts = {
            cwd = get_git_root(),
          }
        end

        require("telescope.builtin").live_grep(opts)
      end, { desc = '[S]earch by [G]rep' })

      vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = '[G]it [S]tatus' })
      vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches, { desc = '[G]it [S]tatus' })
      vim.keymap.set('n', '<leader>u', require("telescope").extensions.undo.undo, { desc = '[S]earch [U]ndo' })
      vim.keymap.set('n', '<leader>s<CR>', require('telescope.builtin').resume, { desc = 'Resume previous [S]earch<CR>' })
      vim.keymap.set('n', '<c-p>', require('telescope.builtin').keymaps, { desc = 'List keymaps' })

      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xf", "<cmd>TroubleToggle lsp_definitions<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xt", "<cmd>TroubleToggle lsp_type_definitions<cr>",
        { silent = true, noremap = true }
      )
    end,
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--trim",
          "--glob",
          "!**/.git/*",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
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
          n = { ["q"] = require("telescope.actions").close },
          i = {
            ["<esc>"] = require("telescope.actions").close,
            ["<c-t>"] =  require("trouble.providers.telescope").smart_open_with_trouble,
            ["<C-Down>"] = require('telescope.actions').cycle_history_next,
            ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
          },
        },
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    },
  },
}