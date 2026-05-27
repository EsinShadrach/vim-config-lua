local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}
local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#f38ba8" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#f9e2af" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#89b4fa" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#fab387" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#a6e3a1" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#cba6f7" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#94e2d5" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup {
  scope = {
    enabled = true,
    highlight = highlight,
  },
  indent = { char = "▏" },
}

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
