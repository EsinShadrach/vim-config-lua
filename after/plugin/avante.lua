-- config for avante.nvim

require("avante").setup({
  provider = "claude",
  auto_suggestions_provider = "claude",
  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-3-5-sonnet-20241022",
    temperature = 0,
    max_tokens = 4096,
  },
  openai = {
    endpoint = "https://api.openai.com/v1",
    model = "gpt-4o-mini", -- your desired model (or use gpt-4o, etc.)
    timeout = 30000,       -- timeout in milliseconds
    temperature = 0,       -- adjust if needed
    max_tokens = 4096,
  },
  behaviour = {
    auto_focus_sidebar = true,
    auto_suggestions = false,
    auto_apply_diff_after_generation = false,
    jump_result_buffer_on_finish = false,
    support_paste_from_clipboard = false,
    minimize_diff = true,
    enable_token_counting = true,
    enable_cursor_planning_mode = false,
  },
  window = {
    input = {
      height = 6, -- Height of the input window in vertical layout
    },
  }
})

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Normal mode mappings
map("n", "<leader>ha", ":AvanteAsk<CR>", opts)
map("n", "<leader>hb", ":AvanteBuild<CR>", opts)
map("n", "<leader>hc", ":AvanteChat<CR>", opts)
map("n", "<leader>hf", ":AvanteFocus<CR>", opts)
map("n", "<leader>hr", ":AvanteRefresh<CR>", opts)
map("n", "<leader>hs", ":AvanteSwitchProvider<CR>", opts)
map("n", "<leader>hm", ":AvanteShowRepoMap<CR>", opts)
map("n", "<leader>ht", ":AvanteToggle<CR>", opts)

-- Visual mode mappings (selected text will be passed as input)
map("v", "<leader>ha", ':<C-u>AvanteAsk position=right "<C-r><C-w>"<CR>', opts)
map("v", "<leader>he", ':<C-u>AvanteEdit<CR>', opts)
