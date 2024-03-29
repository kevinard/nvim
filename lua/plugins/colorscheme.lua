-- Set colorscheme
local themeFlavour = os.getenv("CATPPUCCIN_FLAVOUR") or "mocha"

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = themeFlavour, -- latte, frappe, macchiato, mocha
      background = {
        -- :h background
        light = "latte",
        dark = "mocha",
      },
      styles = {
        conditionals = {},
      },
      integrations = {
        aerial = true,
        alpha = true,
        dashboard = true,
        flash = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        markdown = true,
        mini = true,
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        telescope = true,
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
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
          inlay_hints = {
            background = true,
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
        mason = true,
        which_key = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
      },
      custom_highlights = function(colors)
        return {
          DiagnosticVirtualTextError = { bg = colors.none },
          DiagnosticVirtualTextWarn = { bg = colors.none },
          DiagnosticVirtualTextInfo = { bg = colors.none },
          DiagnosticVirtualTextHint = { bg = colors.none },
          TelescopePromptPrefix = { bg = colors.surface0, fg = colors.mauve },
          TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
          TelescopePromptTitle = { fg = colors.mauve, bg = colors.surface0 },
          TelescopePromptNormal = { bg = colors.surface0, fg = colors.text },
          TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
          TelescopeResultsTitle = { fg = colors.mantle },
          TelescopeResultsNormal = { bg = colors.mantle, fg = colors.subtext1 },
          TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
          TelescopePreviewTitle = { fg = colors.crust },
          TelescopePreviewNormal = { bg = colors.crust },
        }
      end,
    },
  },
}
