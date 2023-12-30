print('code_screenshot.lua')
-- Map Ray command to <F5> in visual mode
vim.api.nvim_set_keymap('v', '<F5>', ':Ray<CR>', { noremap = true })
