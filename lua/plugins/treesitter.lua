return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ':TSUpdate',
    main = "nvim-treesitter.configs",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
          -- When in diff mode, we want to use the default
          -- vim text objects c & C instead of the treesitter ones.
          local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
          local configs = require("nvim-treesitter.configs")
          for name, fn in pairs(move) do
            if name:find("goto") == 1 then
              move[name] = function(q, ...)
                if vim.wo.diff then
                  local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
                  for key, query in pairs(config or {}) do
                    if q == query and key:find("[%]%[][cC]") then
                      vim.cmd("normal! " .. key)
                      return
                    end
                  end
                end
                return fn(q, ...)
              end
            end
          end
        end,
      },
      'RRethy/nvim-treesitter-endwise',
      {
        'RRethy/vim-illuminate',
        opts = {
          -- providers: provider used to get references in the buffer, ordered by priority
          providers = {
            'lsp',
            'treesitter',
            'regex',
          },
          -- delay: delay in milliseconds
          delay = 120,
          -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
          filetypes_denylist = {
            "dirvish",
            "dirbuf",
            "fugitive",
            "help",
            "terminal",
            "packer",
            "lspinfo",
            "TelescopePrompt",
            "TelescopeResults",
            "mason",
            "checkhealth",
            "man",
            "toggleterm",
            "NvimTree",
            "DressingSelect",
          },
          -- under_cursor: whether or not to illuminate under the cursor
          under_cursor = true,
          -- min_count_to_highlight: minimum number of matches required to perform highlighting
          min_count_to_highlight = 2,
        },
        config = function (_, opts)
          require("illuminate").configure(opts)
          vim.keymap.set("n", "<leader>i", "<cmd> IlluminateToggle <CR>")
        end
      },
    },
    -- cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    -- keys = {
    --   { "<c-space>", desc = "Increment selection" },
    --   { "<bs>", desc = "Decrement selection", mode = "x" },
    -- },
    opts = {
      sync_install = false,
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "go",
        "gomod",
        "gosum",
        "dockerfile",
        "ruby",
        "hcl",
        "ledger",
      },

      highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = false,
          node_decremental = '<backspace>',
        },
      },
      endwise = {
        enable = true,
      },
      textobjects = {
        lsp_interop = {
          enable = true,
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
          },
        },
        keymaps = {
          ["iL"] = {
            -- you can define your own textobjects directly here
            go = "(function_definition) @function",
          },
          -- or you use the queries from supported languages with textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["aC"] = "@class.outer",
          ["iC"] = "@class.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["ae"] = "@block.outer",
          ["ie"] = "@block.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["is"] = "@statement.inner",
          ["as"] = "@statement.outer",
          ["ad"] = "@comment.outer",
          ["am"] = "@call.outer",
          ["im"] = "@call.inner"
        },
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']f'] = '@function.outer',
            [']c'] = '@class.outer',
          },
          goto_next_end = {
            [']F'] = '@function.outer',
            [']C'] = '@class.outer',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[c'] = '@class.outer',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[C'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
    },
  },

  -- Show context of the current function
  {
    "nvim-treesitter/nvim-treesitter-context",
    -- event = "LazyFile",
    enabled = true,
    opts = { mode = "cursor" },
    keys = {
      {
        "<leader>ut",
        function()
          require("treesitter-context").toggle()
        end,
        desc = "Toggle Treesitter Context",
      },
    },
  },
}
