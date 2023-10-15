return {
  -- Git related plugins
  'tpope/vim-fugitive',
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    keys = {
      { "<leader>gd", "<cmd> DiffviewOpen <CR>" },
      { "<leader>gc", "<cmd> DiffviewClose <CR>" },
      { "<leader>gh", "<cmd> DiffviewFileHistory % <CR>" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
      hooks = {
        diff_buf_read = function(bufnr)
          -- Change local options in diff buffers
          vim.opt_local.wrap = false
          vim.opt_local.list = false
          vim.opt_local.colorcolumn = { 80 }
        end,
      }
    },
  },

  {        -- Add/change/delete surrounding delimiter pairs with ease
    'kylechui/nvim-surround',
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
  },

  {
    'ThePrimeagen/refactoring.nvim',
    init = function ()
      -- load refactoring Telescope extension
      require("telescope").load_extension("refactoring")

      -- remap to open the Telescope refactoring menu in visual mode
      vim.api.nvim_set_keymap(
        "v",
        "<leader>rr",
        "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
        { noremap = true }
      )
    end,
    opts = {
      prompt_func_return_type = {
        go = true,
      },
      prompt_func_param_type = {
        go = true,
      },
    },
  },

  {
    'Shatur/neovim-session-manager',
    init = function ()
      vim.keymap.set("n", "<leader>sm", "<cmd>SessionManager load_session<CR>")
      vim.keymap.set("n", "<leader>ms", "<cmd>SessionManager delete_session<CR>")
    end,
    opts = {
      autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
      autosave_last_session = true, -- Automatically save last session on exit and on session switch.
      autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
      autosave_ignore_dirs = {}, -- A list of directories where the session will not be autosaved.
      autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
        "gitcommit",
        "help",
        "terminal",
        "packer",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "checkhealth",
        "man",
        "toggleterm",
        "NvimTree",
        "DressingSelect",
      },
      autosave_ignore_buftypes = {}, -- All buffers of these bufer types will be closed before the session is saved.
      autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
      max_path_length = 80,  -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
    },
  },

  { -- Terminal
    'akinsho/toggleterm.nvim',
    version = '*',
    init = function ()
      vim.keymap.set('n', "<A-i>", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm float" })
      vim.keymap.set('n', "<A-h>", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "ToggleTerm horizontal split" })
      vim.keymap.set('n', "<A-v>", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "ToggleTerm vertical split" })
      vim.keymap.set({'n', 't', 'i'}, "<F7>", "<cmd>ToggleTermToggleAll<cr>", { desc = "Toggle terminal" })

      -- escape terminal mode
      vim.keymap.set("t", "<esc><esc>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true))

      -- navigate within terminal mode
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]])
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]])
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]])
      vim.keymap.set('t', '<C-Left>', [[<Cmd>wincmd h<CR>]])
      vim.keymap.set('t', '<C-Down>', [[<Cmd>wincmd j<CR>]])
      vim.keymap.set('t', '<C-Up>', [[<Cmd>wincmd k<CR>]])
      vim.keymap.set('t', '<C-Right>', [[<Cmd>wincmd l<CR>]])
    end,
    opts = {
      open_mapping = [[<A-'>]],
      shade_terminals = false,
      autochdir = true,
      insert_mappings = true,
      terminal_mappings = true,
    },
  },

  { 'nvim-tree/nvim-web-devicons', lazy = true },
  {
    'numToStr/Comment.nvim',
    keys = {
      { '<leader>/', function()
        require("Comment.api").toggle.linewise.current()
      end },
      { '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", mode = "v" },
    },
  },

  {
    'ray-x/go.nvim',
    ft = 'go',
    opts = {
      goimport = 'gopls', -- if set to 'gopls' will use golsp format
      gofmt = 'gopls',    -- if set to gopls will use golsp format
      lsp_cfg = false,
      lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
      dap_debug = true,
    },
  },
  "alker0/chezmoi.vim",
  'junegunn/vim-easy-align',

  { 'ledger/vim-ledger', ft = 'ledger' },
}
