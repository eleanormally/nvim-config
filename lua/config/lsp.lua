local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, buffnr)
  -- only load keybindings when lsp is attached to buffer
  lsp_zero.default_keymaps({ buffer = buffnr })

  -- enable autoformatting
  lsp_zero.buffer_autoformat()
end)

for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
  local default_diagnostic_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, result, context, config)
    if err ~= nil and err.code == -32802 then
      return
    end
    return default_diagnostic_handler(err, result, context, config)
  end
end

-- setup mason
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    lsp_zero.default_setup,
  }
})

-- better lua autocomplete vim plugins
lsp_zero.use('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      }
    }
  }
})

-- disable formatter for html
local lspconfig = require("lspconfig")
lspconfig.html.setup({
  filetypes = { "html", "templ" },
  init_options = {
    provideFormatter = false
  }
})

lspconfig.htmx.setup({
  filetypes = { "templ", "react", "typescript", "javascript", "html" }
})

lspconfig.tailwindcss.setup({
  filetypes = { "templ", "javascript", "typescript", "react" },
  init_options = { userLanguages = { templ = "html" } },
})

lspconfig.sourcekit.setup({
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
})

-- setup autocomplete

local cmp = require('cmp')

cmp.setup({
  preselect = 'item',
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    -- confirm completion
    ['<C-u>'] = cmp.mapping.confirm(),
    ['<C-e>'] = cmp.mapping.abort(),

    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),

    -- remove arrows
    ['<Down>'] = cmp.mapping(function(fallback)
      cmp.close()
      fallback()
    end, { "i" }),
    ['<Up>'] = cmp.mapping(function(fallback)
      cmp.close()
      fallback()
    end, { "i" }),
  },
})
