require('refactoring').setup({
  prompt_func_return_type = {
    go = true,
  },
  prompt_func_param_type = {
    go = true,
  },
})

-- load refactoring Telescope extension
require("telescope").load_extension("refactoring")

-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
  "v",
  "<leader>rr",
  "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
  { noremap = true }
)
