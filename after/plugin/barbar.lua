-- Set barbar's options
require("scope").setup()
require'bufferline'.setup()

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
