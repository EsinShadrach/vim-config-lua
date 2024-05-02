-- Open NERDTree with leader key mapping
vim.api.nvim_set_keymap('n', '<Leader>n', ':NERDTreeToggle<CR>', { noremap = true })

-- Show hidden files by default
vim.g.NERDTreeShowHidden = 1

-- Ignore specific files in NERDTree
vim.g.NERDTreeIgnore = { '\\.git$', '\\.swp$' }

-- Enable nerdtree-git-plugin and set custom indicators
vim.g.NERDTreeGitStatusIndicatorMapCustom = {
  Modified = "✹",
  Staged = "✚",
  Untracked = "✭",
  Renamed = "➜",
  Unmerged = "═",
  Deleted = "✖",
  Dirty = "✗",
  Clean = "✔︎",
  Ignored = "☒",
  Unknown = "?"
}
vim.g.NERDTreeWinPos = "right"
