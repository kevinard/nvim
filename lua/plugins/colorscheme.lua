-- Set colorscheme
local themeFlavour = os.getenv("CATPPUCCIN_FLAVOUR") or "mocha"

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    opts = {
      flavour = themeFlavour, -- latte, frappe, macchiato, mocha
      styles = {
        conditionals = {},
      },
      integrations = {
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
          },
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
            ok = { "undercurl" },
          },
          inlay_hints = {
            background = false,
          },
        },
      },
      custom_highlights = function(colors)
        return {
          DiagnosticVirtualTextError = { bg = colors.none },
          DiagnosticVirtualTextWarn = { bg = colors.none },
          DiagnosticVirtualTextInfo = { bg = colors.none },
          DiagnosticVirtualTextHint = { bg = colors.none },
        }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
