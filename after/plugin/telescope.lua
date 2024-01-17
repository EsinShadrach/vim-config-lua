local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})

vim.api.nvim_set_keymap('n', '<leader>fw', ':Telescope live_grep<CR>', { noremap = true, silent = true })
