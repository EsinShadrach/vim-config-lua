-- Configure Markdown Preview plugin in Lua

vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1
vim.g.mkdp_refresh_slow = 0
vim.g.mkdp_command_for_global = 0
vim.g.mkdp_open_to_the_world = 0
vim.g.mkdp_open_ip = ''
vim.g.mkdp_browser = ''
vim.g.mkdp_echo_preview_url = 0
vim.g.mkdp_browserfunc = ''

vim.g.mkdp_preview_options = {
  mkit = {},
  katex = {},
  uml = {},
  maid = {},
  disable_sync_scroll = 0,
  sync_scroll_type = 'middle',
  hide_yaml_meta = 1,
  sequence_diagrams = {},
  flowchart_diagrams = {},
  content_editable = false,
  disable_filename = 0,
  toc = {}
}

vim.g.mkdp_markdown_css = ''
vim.g.mkdp_highlight_css = ''
vim.g.mkdp_port = ''
vim.g.mkdp_page_title = '「${name}」'
vim.g.mkdp_images_path = '/home/user/.markdown_images'
vim.g.mkdp_filetypes = { 'markdown' }
vim.g.mkdp_theme = 'dark'
vim.g.mkdp_combine_preview = 0
vim.g.mkdp_combine_preview_auto_refresh = 1


-- Key mappings for Markdown Preview in Lua

-- Normal mode mapping to trigger MarkdownPreview
vim.api.nvim_set_keymap('n', '<C-s>', '<Plug>MarkdownPreview', { noremap = true, silent = true })

-- Normal mode mapping to stop MarkdownPreview
-- vim.api.nvim_set_keymap('n', '<M-s>', '<Plug>MarkdownPreviewStop', { noremap = true, silent = true })

-- Normal mode mapping to toggle MarkdownPreview
-- vim.api.nvim_set_keymap('n', '<C-p>', '<Plug>MarkdownPreviewToggle', { noremap = true, silent = true })

-- Insert mode mapping to trigger MarkdownPreview
vim.api.nvim_set_keymap('i', '<C-s>', '<Plug>MarkdownPreview', { noremap = true, silent = true })

-- Insert mode mapping to stop MarkdownPreview
-- vim.api.nvim_set_keymap('i', '<M-s>', '<Plug>MarkdownPreviewStop', { noremap = true, silent = true })

-- Insert mode mapping to toggle MarkdownPreview
-- vim.api.nvim_set_keymap('i', '<C-p>', '<Plug>MarkdownPreviewToggle', { noremap = true, silent = true })

vim.cmd([[
  command! MarkdownPreview :call ToggleMarkdownPreview()
]])

-- Function to toggle Markdown Preview
function ToggleMarkdownPreview()
  vim.api.nvim_command('MarkdownPreviewToggle')
end
