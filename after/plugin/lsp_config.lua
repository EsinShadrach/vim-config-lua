local lspconfig = require('lspconfig')

require("lspconfig").lua_ls.setup {
  -- on_attach = on_attach,
}

-- Setup language servers.
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}
require 'lspconfig'.kotlin_language_server.setup {}
