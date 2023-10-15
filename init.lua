-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("lazy").setup("plugins", {
  defaults = {
    lazy = false,  -- should plugins be lazy-loaded?
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        -- "matchit",
        -- "matchparen",
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
})

vim.loader.enable()

require("settings")
require("mappings")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Remove trailing spaces before saving file
local trailingspaces_group = vim.api.nvim_create_augroup('TrailingSpaces', {})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = trailingspaces_group,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- dont list quickfix buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Make q close help, man, quickfix, dap floats",
  group = vim.api.nvim_create_augroup("q_close_windows", { clear = true }),
  pattern = { "qf", "help", "man", "dap-float" },
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, nowait = true })
  end,
})
