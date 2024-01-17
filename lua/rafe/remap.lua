vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.api.nvim_set_keymap("n", "<C-P>", ":Format<CR>", { noremap = true, silent = true })
