-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

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

-- vim.g.maplocalleader = "\\"
-- opt.numberwidth = 2
opt.swapfile = false
opt.title = true
-- opt.ruler = false
opt.spelllang = { "en", "fr" }
opt.breakindent = true
-- opt.softtabstop = 2
opt.autoindent = false
opt.listchars:append("tab:>-,trail:·,eol:¬,nbsp:⋅,space:⋅")
opt.shortmess:append("s")
-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]")
opt.completeopt = "menu,menuone,preview,noinsert,noselect"
opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore
opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }

opt.autowrite = false --  Disable auto write
opt.list = false
opt.wrap = true
