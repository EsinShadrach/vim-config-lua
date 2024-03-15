vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", "<C-P>", ":Format<CR>", { noremap = true, silent = true })

-- a function to visually select everything
function VisualSelectAll()
  vim.cmd [[normal! ggVG]]
end

-- A function to visually select everything and copy it to the clipboard
function VisualSelectAllAndCopy()
  VisualSelectAll()
  vim.cmd [[normal! "+y]]
end

-- A function to visually Select a Line and copy to clipboard
function SelectLine()
  vim.cmd [[normal! V]]
  vim.cmd [[normal! "+y]]
end

-- Create a mapping for the function
vim.api.nvim_set_keymap('n', '<leader>va', '<cmd>lua VisualSelectAll()<CR>', { noremap = true, silent = true })
-- mapping for the function to copy to clipboard
vim.api.nvim_set_keymap('n', '<leader>vc', '<cmd>lua VisualSelectAllAndCopy()<CR>', { noremap = true, silent = true })
-- mapping for the function to copy a line to clipboard
vim.api.nvim_set_keymap('n', '<leader>vl', '<cmd>lua SelectLine()<CR>', { noremap = true, silent = true })
