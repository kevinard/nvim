-- Tree
local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

require("nvim-tree").setup {
  on_attach = on_attach,
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
}

vim.keymap.set('n', '<C-n>', '<cmd> NvimTreeToggle <CR>')
vim.keymap.set('n', '<leader>o', '<cmd> NvimTreeFocus <CR>')

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
