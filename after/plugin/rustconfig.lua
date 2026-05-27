local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

vim.lsp.handlers['textDocument/hover'] = vim.lsp.handlers.hover
vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'FloatBorder' })
vim.opt.winborder = 'rounded'

vim.lsp.config['rust-analyzer'] = {
  settings = {
    ['rust-analyzer'] = {
      inlayHints = {
        parameterHints = { enable = true, prefix = "<- " },
        typeHints = { enable = true, prefix = "=> " },
        chainingHints = { enable = true },
      },
    },
  },
}
vim.lsp.enable('rust-analyzer')

vim.lsp.inlay_hint.enable(true)

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  callback = function()
    vim.keymap.set("n", "<C-space>", vim.lsp.buf.hover, { buffer = true })
    vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action, { buffer = true })
  end,
})
