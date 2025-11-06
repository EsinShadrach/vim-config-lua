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

-- vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
--   callback = function()
--     local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
--     if not normal.bg then return end
--     io.write(string.format("\027]11;#%06x\027\\", normal.bg))
--   end,
-- })

-- vim.api.nvim_create_autocmd("UILeave", {
--   callback = function() io.write("\027]111\027\\") end,
-- })

-- Auto-sync terminal background with Neovim's theme (dark mode only)
-- Works on macOS and terminals that support OSC 11 (Kitty, iTerm2, WezTerm, etc.)

-- Helper to detect macOS dark mode
local function is_dark_mode()
  local handle = io.popen('defaults read -g AppleInterfaceStyle 2>/dev/null')

  if handle == nil then
    return
  end

  local result = handle:read('*a')
  handle:close()
  return result:match('Dark') ~= nil
end

-- Set terminal background color (OSC 11)
local function set_terminal_bg(color)
  io.write(string.format('\027]11;#%06x\027\\', color))
end

-- Reset terminal background to default (OSC 111)
local function reset_terminal_bg()
  io.write('\027]111\027\\')
end

-- Apply only when in dark mode and Neovim has a bg color
vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
  callback = function()
    if not is_dark_mode() then return end
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if not normal.bg then return end
    set_terminal_bg(normal.bg)
  end,
})

-- Restore terminal background when leaving Neovim
vim.api.nvim_create_autocmd('UILeave', {
  callback = reset_terminal_bg,
})
