return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ansiblels = {},
        bashls = {},
        dockerls = {},
        docker_compose_language_service = {},
        terraformls = {},
        marksman = {},
        gopls = {
          capabilities = {
            textDocument = {
              completion = {
                completionItem = {
                  commitCharactersSupport = true,
                  deprecatedSupport = true,
                  documentationFormat = { "markdown", "plaintext" },
                  preselectSupport = true,
                  insertReplaceSupport = true,
                  labelDetailsSupport = true,
                  snippetSupport = true,
                  resolveSupport = {
                    properties = {
                      "documentation",
                      "details",
                      "additionalTextEdits",
                    },
                  },
                },
                contextSupport = true,
                dynamicRegistration = true,
              },
            },
          },
          filetypes = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
          message_level = vim.lsp.protocol.MessageType.Error,
          cmd = {
            "gopls", -- share the gopls instance if there is one already
            "-remote.debug=:0",
          },
          root_dir = function(fname)
            local has_lsp, lspconfig = pcall(require, "lspconfig")
            if has_lsp then
              local util = lspconfig.util
              return util.root_pattern("go.work", "go.mod")(fname)
                or util.root_pattern(".git")(fname)
                or util.path.dirname(fname)
            end
          end,
          flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
          settings = {
            gopls = {
              analyses = {
                unreachable = true,
                nilness = true,
                unusedparams = true,
                useany = true,
                unusedwrite = true,
                ST1003 = true,
                undeclaredname = true,
                fillreturns = true,
                nonewvars = true,
                fieldalignment = true,
                -- fieldalignment = false,
                shadow = true,
              },
              codelenses = {
                gc_details = true,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              gofumpt = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              usePlaceholders = true,
              semanticTokens = true,
              completeUnimported = true,
              staticcheck = true,
              matcher = "Fuzzy",
              diagnosticsDelay = "500ms",
              symbolMatcher = "fuzzy",
              buildFlags = { "-tags", "integration" },
              ["local"] = "github.com/Scalingo",
            },
          },
          -- NOTE: it is important to add handler to formatting handlers
          -- the async formatter will call these handlers when gopls responed
          -- without these handlers, the file will not be saved
          -- handlers = {
          --   [range_format] = function(...)
          --     vim.lsp.handlers[range_format](...)
          --     if vfn.getbufinfo("%")[1].changed == 1 then
          --       vim.cmd("noautocmd write")
          --     end
          --   end,
          --   [formatting] = function(...)
          --     vim.lsp.handlers[formatting](...)
          --     if vfn.getbufinfo("%")[1].changed == 1 then
          --       vim.cmd("noautocmd write")
          --     end
          --   end,
          -- },
        },
        solargraph = {
          settings = {
            solargraph = {
              diagnostics = true,
              completion = true,
              hover = true,
              formatting = true,
              symbols = true,
              definitions = true,
              rename = true,
              references = true,
              logLevel = "warn",
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              telemetry = { enable = false },
              hint = { enable = true },
              runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = vim.split(package.path, ";"),
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
              },
              completion = { callSnippet = "Both" },
              workspace = {
                checkThirdParty = false,
                -- Make the server aware of Neovim runtime files
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "shfmt",
        "tflint",
      })
    end,
  },
}
