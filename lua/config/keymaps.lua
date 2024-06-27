-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- quit
vim.keymap.set("n", "<c-q>", "<cmd>qa<cr>", { desc = "Quit all" })

-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set("n", "J", "mzJ`z") -- put the line below at the end of the current line without moving the cursor
-- paste/replace over the highlighted text without replacing the paste buffer
vim.keymap.set({ "v", "x" }, "p", [["_dP]])
-- delete the selection without adding it to the paste buffer
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
-- paste from the system clipboard
vim.keymap.set("i", "<C-v>", "<C-r>+")

-- command mode
vim.keymap.set({ "n", "x" }, ";", ":", { nowait = true })
-- make the current file executable
vim.keymap.set("n", "<leader>fx", "<cmd>!chmod +x %<CR>", { silent = true })

-- copy whole file
vim.keymap.set("n", "<C-c>", "<cmd> %y+ <CR>")

-- copy the selection to the system clipboard
vim.keymap.set("v", "<C-c>", '"+y')
-- Select all
vim.keymap.set("n", "<C-a>", "gg0vG$")

-- Search word under cursor
vim.keymap.set("n", "gw", "*N")
