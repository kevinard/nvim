-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  if client.name == 'gopls' then
    nmap('<leader>ra', require('go.rename').run, '[R]e[n]ame')
  else
    nmap('<leader>ra', vim.lsp.buf.rename, '[R]e[n]ame')
  end
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  vim.keymap.set('x', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('gs', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Diagnostic keymaps
  nmap('[d', vim.diagnostic.goto_prev)
  nmap(']d', vim.diagnostic.goto_next)
  nmap('<leader>e', vim.diagnostic.open_float)
  nmap('<leader>q', function()
    require('telescope.builtin').diagnostics({ bufnr = 0 })
  end)

  -- format the file
  if client.server_capabilities.documentFormattingProvider then
    nmap('<leader>fm', vim.lsp.buf.format)
    vim.keymap.set('x', '<leader>fm', vim.lsp.buf.format, { buffer = bufnr })
  end
  -- if client.supports_method("textDocument/formatting") then
  --   vim.keymap.set("n", "<Leader>f", function()
  --     vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
  --   end, { buffer = bufnr, desc = "[lsp] format" })
  --
  --   -- format on save
  --   vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
  --   vim.api.nvim_create_autocmd(event, {
  --     buffer = bufnr,
  --     group = group,
  --     callback = function()
  --       vim.lsp.buf.format({ bufnr = bufnr, async = async })
  --     end,
  --     desc = "[lsp] format on save",
  --   })
  -- end
  --
  -- if client.supports_method("textDocument/rangeFormatting") then
  --   vim.keymap.set("x", "<Leader>f", function()
  --     vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
  --   end, { buffer = bufnr, desc = "[lsp] format" })
  -- end

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  local function lspSymbol(name, icon)
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
  end

  lspSymbol("Error", "")
  lspSymbol("Info", "")
  lspSymbol("Hint", "")
  lspSymbol("Warn", "")

  vim.diagnostic.config {
    virtual_text = {
      prefix = "",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  }

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
    focusable = false,
    relative = "cursor",
  })

  -- suppress error messages from lang servers
  vim.notify = function(msg, log_level)
    if msg:match "exit code" then
      return
    end
    if log_level == vim.log.levels.ERROR then
      vim.api.nvim_err_writeln(msg)
    else
      vim.api.nvim_echo({ { msg } }, true, {})
    end
  end

  -- Borders for LspInfo window
  require('lspconfig.ui.windows').default_options.border = 'single'

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  if client.server_capabilities.codeLensProvider then
    vim.api.nvim_set_hl(0, 'LspCodeLens', { link = 'WarningMsg', default = true })
    vim.api.nvim_set_hl(0, 'LspCodeLensText', { link = 'WarningMsg', default = true })
    vim.api.nvim_set_hl(0, 'LspCodeLensSign', { link = 'WarningMsg', default = true })
    vim.api.nvim_set_hl(0, 'LspCodeLensSeparator', { link = 'Boolean', default = true })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI', 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup('codelenses', {}),
      buffer = bufnr,
      callback = function()
        vim.lsp.codelens.refresh()
      end,
    })
    nmap('<leader>cl', vim.lsp.codelens.run, '[C]ode [L]ens')
  end
end

--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local lspconfig = require('lspconfig')
local base_capabilities = lspconfig.util.default_config.capabilities
base_capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local capabilities = require('cmp_nvim_lsp').default_capabilities(base_capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup {
  ui = {
    icons = {
      package_installed = "✓",
      package_uninstalled = "✗",
      package_pending = "⟳",
    },
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },
}

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  ansiblels = {},
  bashls = {},
  dockerls = {},
  yamlls = {},
  gopls = {
    gopls = {
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = { unusedparams = true, unreachable = false, shadow = true },
      codelenses = {
        generate = true,   -- show the `go generate` lens.
        gc_details = true, --  // Show a code lens toggling the display of gc's choices.
        test = true,
        tidy = true
      },
      usePlaceholders = true,
      completeUnimported = true,
      experimentalPostfixCompletions = true,
      staticcheck = true,
      matcher = "fuzzy",
      diagnosticsDelay = "500ms",
      symbolMatcher = "fuzzy",
      gofumpt = false, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
      buildFlags = { "-tags", "integration" },
      ['local'] = 'github.com/Scalingo',
    },
  },
  jsonls = {},
  marksman = {},
  solargraph = {
    diagnostics = true,
  },
  terraformls = {},
  lua_ls = {
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
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
      },
    },
  },
}

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

local get_servers = mason_lspconfig.get_installed_servers

for _, server_name in ipairs(get_servers()) do
  lspconfig[server_name].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = servers[server_name],
  })
end

require 'go'.setup({
  goimport = 'gopls', -- if set to 'gopls' will use golsp format
  gofmt = 'gopls',    -- if set to gopls will use golsp format
  lsp_cfg = false,
  lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
  dap_debug = true,
})

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = format_sync_grp,
})

-- Turn on lsp status information
require('fidget').setup {
  window = {
    blend = 0,
  },
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

local kind_icons = {
  Namespace = "",
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "ﰠ ",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = " ",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = " ",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
  Table = "",
  Object = " ",
  Tag = "",
  Array = "[]",
  Boolean = " ",
  Number = " ",
  Null = "ﳠ",
  String = " ",
  Calendar = "",
  Watch = " ",
  Package = "",
  Copilot = " ",
}

cmp.setup {
  completion = {
    completeopt = vim.o.completeopt,
  },
  window = {
    completion = {
      border = "single",
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      side_padding = 1,
      scrollbar = false,
    },
    documentation = {
      border = "single",
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
    },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    fields = { 'abbr', 'kind', 'menu' },
    format = function(_, vim_item)
      vim_item.kind = string.format("%s  %s", kind_icons[vim_item.kind], vim_item.kind)
      return vim_item
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = "treesitter" },
    { name = "buffer" },
    { name = 'luasnip' },
    { name = "path" },
  },
}

-- Use buffer source for `/`
cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

require("nvim-autopairs").setup {
  check_ts = true,
  enable_check_bracket_line = false,
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0,
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
}
cmp.event:on(
  'confirm_done',
  require('nvim-autopairs.completion.cmp').on_confirm_done()
)
