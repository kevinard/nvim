return {
  {
    'romgrk/barbar.nvim',
    main = 'bufferline',
    init = function ()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      -- Move to previous/next
      map('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', opts)
      map('n', '<Tab>', '<Cmd>BufferNext<CR>', opts)
      -- Re-order to previous/next
      map('n', '<A-S-Tab>', '<Cmd>BufferMovePrevious<CR>', opts)
      map('n', '<A-Tab>', '<Cmd>BufferMoveNext<CR>', opts)
      -- Pin/unpin buffer
      map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
      -- Close buffer
      map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
      -- Wipeout buffer
      --                 :BufferWipeout
      -- Magic buffer-picking mode
      map('n', '<A-S-p>', '<Cmd>BufferPick<CR>', opts)

      -- Open a new nvim tab
      map('n', '<A-t>', '<Cmd>tabnew<CR>', opts)
      -- Close current nvim tab
      map('n', '<A-S-c>', '<Cmd>tabclose<CR>', opts)
    end,
    dependencies = {
      "tiagovla/scope.nvim",
    },
  },
  {
    'stevearc/dressing.nvim',
    event = "VeryLazy",
    opts = {
      input = {
        default_prompt = "➤ ",
        border = "single",
        win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" },
      },
      select = {
        backend = { "telescope", "builtin" },
        builtin = {
          border = "single",
          win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" }
        },
      },
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    init = function()
      vim.api.nvim_set_keymap('n', '<leader>sl', '<cmd> IBLToggle <CR>', {})
      vim.api.nvim_set_keymap('n', '<leader>cc', '<cmd> IBLToggleScope <CR>', {})
    end,
    opts = {
      indent = {
        char = "▏",
      },
      exclude = {
        filetypes = {
          "help",
          "terminal",
          "packer",
          "lspinfo",
          "gitcommit",
          "TelescopePrompt",
          "TelescopeResults",
          "mason",
          "checkhealth",
          "man",
          "NvimTree",
          "toggleterm",
          "Trouble",
          "",
        },
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        -- highlight = {
          -- "IndentBlanklineIndent6",
        -- },
      },
    },
  },
  {
    'mrjones2014/smart-splits.nvim',
    build = './kitty/install-kittens.bash',
    keys = {
      { '<S-left>', require('smart-splits').resize_left },
      { '<S-down>', require('smart-splits').resize_down },
      { '<S-up>', require('smart-splits').resize_up },
      { '<S-right>', require('smart-splits').resize_right },
      { '<C-left>', require('smart-splits').move_cursor_left },
      { '<C-down>', require('smart-splits').move_cursor_down },
      { '<C-up>', require('smart-splits').move_cursor_up },
      { '<C-right>', require('smart-splits').move_cursor_right },
      { '<C-h>', require('smart-splits').move_cursor_left },
      { '<C-j>', require('smart-splits').move_cursor_down },
      { '<C-k>', require('smart-splits').move_cursor_up },
      { '<C-l>', require('smart-splits').move_cursor_right },
      { '<leader><leader>h', require('smart-splits').swap_buf_left },
      { '<leader><leader>j', require('smart-splits').swap_buf_down },
      { '<leader><leader>k', require('smart-splits').swap_buf_up },
      { '<leader><leader>l', require('smart-splits').swap_buf_right },
      { '<leader><leader>left', require('smart-splits').swap_buf_left },
      { '<leader><leader>down', require('smart-splits').swap_buf_down },
      { '<leader><leader>up', require('smart-splits').swap_buf_up },
      { '<leader><leader>right', require('smart-splits').swap_buf_right },
    },
    opts = {
      -- Ignored filetypes (only while resizing)
      ignored_filetypes = {
        'nofile',
        'quickfix',
        'prompt',
      },
      -- Ignored buffer types (only while resizing)
      ignored_buftypes = { 'NvimTree' },
      -- the default number of lines/columns to resize by at a time
      default_amount = 3,
      -- Desired behavior when your cursor is at an edge and you
      -- are moving towards that same edge:
      -- 'wrap' => Wrap to opposite side
      -- 'split' => Create a new split in the desired direction
      -- 'stop' => Do nothing
      -- function => You handle the behavior yourself
      -- NOTE: If using a function, the function will be called with
      -- a context object with the following fields:
      -- {
      --    mux = {
      --      type:'tmux'|'wezterm'|'kitty'
      --      current_pane_id():number,
      --      is_in_session(): boolean
      --      current_pane_is_zoomed():boolean,
      --      -- following methods return a boolean to indicate success or failure
      --      current_pane_at_edge(direction:'left'|'right'|'up'|'down'):boolean
      --      next_pane(direction:'left'|'right'|'up'|'down'):boolean
      --      resize_pane(direction:'left'|'right'|'up'|'down'):boolean
      --      split_pane(direction:'left'|'right'|'up'|'down',size:number|nil):boolean
      --    },
      --    direction = 'left'|'right'|'up'|'down',
      --    split(), -- utility function to split current Neovim pane in the current direction
      --    wrap(), -- utility function to wrap to opposite Neovim pane
      -- }
      -- NOTE: `at_edge = 'wrap'` is not supported on Kitty terminal
      -- multiplexer, as there is no way to determine layout via the CLI
      at_edge = 'stop',
      -- when moving cursor between splits left or right,
      -- place the cursor on the same row of the *screen*
      -- regardless of line numbers. False by default.
      -- Can be overridden via function parameter, see Usage.
      move_cursor_same_row = false,
      -- whether the cursor should follow the buffer when swapping
      -- buffers by default; it can also be controlled by passing
      -- `{ move_cursor = true }` or `{ move_cursor = false }`
      -- when calling the Lua function.
      cursor_follows_swapped_bufs = false,
      -- resize mode options
      resize_mode = {
        -- key to exit persistent resize mode
        quit_key = '<ESC>',
        -- keys to use for moving in resize mode
        -- in order of left, down, up' right
        resize_keys = { 'h', 'j', 'k', 'l' },
        -- set to true to silence the notifications
        -- when entering/exiting persistent resize mode
        silent = false,
        -- must be functions, they will be executed when
        -- entering or exiting the resize mode
        hooks = {
          on_enter = nil,
          on_leave = nil,
        },
      },
      -- ignore these autocmd events (via :h eventignore) while processing
      -- smart-splits.nvim computations, which involve visiting different
      -- buffers and windows. These events will be ignored during processing,
      -- and un-ignored on completed. This only applies to resize events,
      -- not cursor movement events.
      ignored_events = {
        'BufEnter',
        'WinEnter',
      },
      -- enable or disable a multiplexer integration;
      -- automatically determined, unless explicitly disabled or set,
      -- by checking the $TERM_PROGRAM environment variable,
      -- and the $KITTY_LISTEN_ON environment variable for Kitty
      multiplexer_integration = 'kitty',
      -- disable multiplexer navigation if current multiplexer pane is zoomed
      -- this functionality is only supported on tmux and Wezterm due to kitty
      -- not having a way to check if a pane is zoomed
      disable_multiplexer_nav_when_zoomed = true,
      -- Supply a Kitty remote control password if needed,
      -- or you can also set vim.g.smart_splits_kitty_password
      -- see https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.remote_control_password
      kitty_password = nil,
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'catppuccin',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {{'b:gitsigns_head', icon = ''},
          {
            'diagnostics',
            -- Table of diagnostic sources, available sources are:
            --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
            -- or a function that returns a table as such:
            --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
            sources = { 'nvim_diagnostic', 'nvim_lsp' },

            -- Displays diagnostics for the defined severity types
            sections = { 'error', 'warn', 'info', 'hint' },

            diagnostics_color = {
              -- Same values as the general color option can be used here.
              error = 'DiagnosticError', -- Changes diagnostics' error color.
              warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
              info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
              hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
            },
            -- symbols = {error = '', warn = '', info = '', hint = ''},
          }
        },
        lualine_c = {{'filename', path = 1}, 'searchcount'},
        lualine_x = {'encoding', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      extensions = {
        'toggleterm',
        'nvim-tree',
      },
    },
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'romgrk/barbar.nvim',
    init = function ()
      -- Offset barbar when nvim-tree is visible
      local nvim_tree_events = require('nvim-tree.events')
      local bufferline_api = require('bufferline.api')

      local function get_tree_size()
        return require 'nvim-tree.view'.View.width
      end

      nvim_tree_events.subscribe('TreeOpen', function()
        bufferline_api.set_offset(get_tree_size())
      end)

      nvim_tree_events.subscribe('Resize', function()
        bufferline_api.set_offset(get_tree_size())
      end)

      nvim_tree_events.subscribe('TreeClose', function()
        bufferline_api.set_offset(0)
      end)

      vim.api.nvim_set_keymap('n', '<C-n>', '<cmd> NvimTreeToggle <CR>', {})
      vim.api.nvim_set_keymap('n', '<leader>o', '<cmd> NvimTreeFocus <CR>', {})
    end,
    opts = {
      on_attach = function (bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
      end,
      filters = {
        dotfiles = false,
        custom = { "^.git$" },
      },
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = false,
      sync_root_with_cwd = true,
      select_prompts = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      live_filter = {
        always_show_folders = false,
      },
      view = {
        adaptive_size = false,
        side = "left",
        width = 30,
        signcolumn = "yes",
        preserve_window_proportions = true,
      },
      git = {
        enable = true,
        ignore = true,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      filesystem_watchers = {
        enable = true,
      },
      actions = {
        open_file = {
          resize_window = true,
        },
      },
      renderer = {
        group_empty = true,
        full_name = true,
        highlight_git = false,
        highlight_opened_files = "none",
        root_folder_label = function(path)
          return vim.fn.fnamemodify(path, ":t:s?$?/..?")
        end,
        indent_width = 2,
        indent_markers = {
          enable = true,
          inline_arrows = true,
          -- icons = { corner = "└", edge = "│", item = "│", bottom = "─", none = " ", },
          icons = { corner = "▏", edge = "▏", item = "▏", bottom = "▏", none = " ", },
        },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = false,
            git = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            folder = {
              default = "",
              empty = "",
              empty_open = "",
              open = "",
              symlink = "",
              symlink_open = "",
              arrow_open = "",
              arrow_closed = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl                        = true, -- Toggle with `:Gitsigns toggle_numhl`
      current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      on_attach                    = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Actions
        map('n', ']g', gs.next_hunk)
        map('n', '[g', gs.prev_hunk)
        map('n', '<leader>hb', function() gs.blame_line { full = true } end)
        map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>td', gs.toggle_word_diff)
        map('n', '<leader>fd', gs.diffthis)
      end
    },
  },
  {
    'rcarriga/nvim-notify',
    opts = {
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
      },
    },
    init = function ()
      vim.notify = require("notify")
    end,
  },
  { 'MunifTanjim/nui.nvim', },
  {
    'folke/noice.nvim',
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
  },
}
