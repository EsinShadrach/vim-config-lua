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

-- Function to copy the relative path to the clipboard
function CopyRelativePathToClipboard()
  vim.fn.setreg("+", vim.fn.expand("%"))
  print("Copied relative path to clipboard: " .. vim.fn.expand("%"))
end

-- Function to yank the relative path into the default yank register
function YankRelativePath()
  vim.fn.setreg('"', vim.fn.expand("%"))
  print("Yanked relative path: " .. vim.fn.expand("%"))
end

-- Mapping to copy the relative path to the clipboard
vim.api.nvim_set_keymap('n', '<leader>cp', '<cmd>lua CopyRelativePathToClipboard()<CR>',
  { noremap = true, silent = true })

-- Mapping to yank the relative path to the default register
vim.api.nvim_set_keymap('n', '<leader>yp', '<cmd>lua YankRelativePath()<CR>', { noremap = true, silent = true })

-- Create a mapping for the function
vim.api.nvim_set_keymap('n', '<leader>va', '<cmd>lua VisualSelectAll()<CR>', { noremap = true, silent = true })
-- mapping for the function to copy to clipboard
vim.api.nvim_set_keymap('n', '<leader>vc', '<cmd>lua VisualSelectAllAndCopy()<CR>', { noremap = true, silent = true })
-- mapping for the function to copy a line to clipboard
vim.api.nvim_set_keymap('n', '<leader>vl', '<cmd>lua SelectLine()<CR>', { noremap = true, silent = true })
-- Map leader followed by ] to tab next
vim.api.nvim_set_keymap('n', '<leader>]', ':tabnext<CR>', { noremap = true })
-- Map leader followed by [ to tab previous
vim.api.nvim_set_keymap('n', '<leader>[', ':tabprevious<CR>', { noremap = true })

vim.cmd('command! W w')
vim.cmd('command! Wa wa')

vim.api.nvim_create_user_command("ToggleBackground", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, {})

vim.keymap.set("n", "<leader>tb", "<cmd>ToggleBackground<CR>", { desc = "Toggle light/dark background" })
