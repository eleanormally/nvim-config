require('neodev').setup({})
local lsp = require('lsp-zero').preset({})

lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'lua_ls',
})


lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({
    buffer = bufnr,
  })

  local opts = { buffer = bufnr, remap = false }

  lsp.buffer_autoformat()


  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
end)


lsp.use('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      }
    }
  }
})

lsp.setup()

local lspconfig = require("lspconfig")
lspconfig.html.setup({
  filetypes = { "html", "templ" },
  init_options = {
    provideFormatter = false
  }
})
lspconfig.htmx.setup({
  filetypes = { "templ", "react", "typescript", "javascript" }
})
-- lspconfig.tailwincss.setup({
--   filetypes = { "templ", "javascript", "typescript", "react" },
--   init_options = { userLanguages = { templ = "html" } },
-- })

local cmp = require('cmp')


cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- confirm completion
    ['<C-s>'] = cmp.mapping.confirm({ select = true }),

    -- remove arrows
    ['<Down>'] = cmp.mapping(function(fallback)
      cmp.close()
      fallback()
    end, { "i" }),
    ['<Up>'] = cmp.mapping(function(fallback)
      cmp.close()
      fallback()
    end, { "i" }),

  }),
})
