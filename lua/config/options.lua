-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LSP Server to use for Ruby.
vim.g.lazyvim_ruby_lsp = "solargraph" -- solargraph or ruby_lsp
vim.g.lazyvim_ruby_formatter = "rubocop" -- rubocop or standardrb

local default_providers = {
  "node",
  "perl",
  "python3",
  "ruby",
}

for _, provider in ipairs(default_providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

local opt = vim.opt

opt.autoindent = false
opt.autowrite = false --  Disable auto write
opt.breakindent = true
opt.completeopt = "menu,menuone,preview,popup,noinsert,noselect"
opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }
opt.formatoptions = opt.formatoptions -- tcqj
  - "a"
  - "o"
  - "t"
  - "2"
  + "c"
  + "j"
  + "l"
  + "n"
  + "q"
  + "r"
opt.list = false
opt.listchars:append("tab:>-,trail:·,eol:¬,nbsp:⋅,space:⋅")
opt.shortmess:append("s")
opt.spelllang = { "en", "fr" }
opt.swapfile = false
opt.title = true
opt.whichwrap:append("<>[]")
opt.wrap = true
