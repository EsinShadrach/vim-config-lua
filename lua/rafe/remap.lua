vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.api.nvim_set_keymap("n", "<C-P>", ":Format<CR>", { noremap = true, silent = true })

-- a function to visually select everything
function visualSelectAll()
  vim.cmd [[normal! ggVG]]
end

-- Create a mapping for the function
vim.api.nvim_set_keymap('n', '<leader>va', '<cmd>lua visualSelectAll()<CR>', { noremap = true, silent = true })
