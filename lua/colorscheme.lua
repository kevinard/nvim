-- Set colorscheme
local themeFlavour = os.getenv("CATPPUCCIN_FLAVOUR") or "mocha"

require("catppuccin").setup({
  flavour = themeFlavour, -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  styles = {
    conditionals = {},
  },
  integrations = {
    cmp = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
    dap = {
      enabled = true,
      enable_ui = true, -- enable nvim-dap-ui
    },
    treesitter = true,
    treesitter_context = true,
    lsp_trouble = true,
    gitsigns = true,
    nvimtree = true,
    telescope = true,
    barbar = true,
    mason = true,
    which_key = true,
    fidget = true,
    illuminate = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    }, -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
  custom_highlights = function(colors)
    return {
      DiagnosticVirtualTextError = { bg = colors.none },
      DiagnosticVirtualTextWarn = { bg = colors.none },
      DiagnosticVirtualTextInfo = { bg = colors.none },
      DiagnosticVirtualTextHint = { bg = colors.none },
    }
  end
})
vim.cmd.colorscheme "catppuccin"
