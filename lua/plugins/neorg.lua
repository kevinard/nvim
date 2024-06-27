return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    lazy = false,
    version = "*",
    -- config = true,
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.keybinds"] = {
            config = {
              hook = function(keybinds)
                keybinds.map(
                  "norg",
                  "n",
                  keybinds.leader .. "lg",
                  "<cmd>Neorg keybind all core.looking-glass.magnify-code-block<CR>"
                )
              end,
            },
          },
          ["core.concealer"] = { config = { icon_preset = "diamond" } },
          ["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
          ["core.integrations.nvim-cmp"] = {},
          ["core.esupports.metagen"] = { config = { type = "auto", update_date = true } },
          ["core.presenter"] = { config = { zen_mode = "zen-mode" } },
          ["core.summary"] = {},
          ["core.tangle"] = { config = { report_on_empty = false } },
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes/notes",
                work = "~/notes/work",
              },
              default_workspace = "work",
            },
          },
        },
      })
    end,
  },
}
