return {
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<A-S-h>", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer to the left" },
      { "<A-S-l>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer to the right" },
      { "gb", "<cmd>BufferLinePick<cr>", desc = "Go to picked buffer" },
      { "gB", "<cmd>BufferLinePickClose<cr>", desc = "Close picked buffer" },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_z = {},
      },
    },
  },
}
