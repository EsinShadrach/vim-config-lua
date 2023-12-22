require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "rust_analyzer"
  },
})


-- local on_attach = function(_, _)
--   vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
--   vim.keymap.set('n', '<leader>ac', vim.lsp.buf.code_action_group, {})

--   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
--   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
--   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
--   vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
-- end

require("lspconfig").rust_analyzer.setup {
  -- on_attach = on_attach,
}
require("lspconfig").lua_ls.setup {
  -- on_attach = on_attach,
}
