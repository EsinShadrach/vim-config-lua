-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`

local is_macos = vim.loop.os_uname().sysname == "Darwin"
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use({
    "folke/tokyonight.nvim",
    as = "tokyonight",
    config = function()
      require("tokyonight").setup({
        -- Choose the style you want: "night", "storm", "moon", or "day"
        style = "night",
        -- Other configuration options as per your preferences (optional)
        -- For example:
        -- transparent = true,
        -- sidebars = { "qf", "vista_kind", "terminal", "packer" },
        -- on_colors = function(colors)
        --   colors.error = "#ff0000" -- Change the "error" color to bright red
        -- end,
      })
      -- Lualine setup
      require('lualine').setup {
        options = {
          theme = 'tokyonight' -- Set the Lualine theme to Tokyo Night
          -- Other Lualine options as per your preferences
        }
      }
    end
  })
  use({
    'hoob3rt/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      local lualine_os = is_macos and 'macos' or 'linux' -- Specify the OS for Lualine

      require('lualine').setup {
        options = {
          theme = 'tokyonight_' .. lualine_os -- Adjust the Lualine theme based on the OS
          -- Other Lualine options as per your preferences
        }
      }
    end
  })
  use({ 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } })
  use({ 'nvim-treesitter/playground' })
  use({ 'theprimeagen/harpoon' })
  use({ 'mbbill/undotree' })
  use({ 'tpope/vim-fugitive' })
  use({ 'neoclide/coc.nvim', branch = "release" })
  use({ 'jiangmiao/auto-pairs' })
  use({ "preservim/nerdtree" })
  use({ "ap/vim-css-color" })
  use({ 'Xuyuanp/nerdtree-git-plugin' })
  use({ "tpope/vim-surround" })
  use({ 'ryanoasis/vim-devicons' })
  use({ 'mattn/emmet-vim' })
  use({ 'dart-lang/dart-vim-plugin' })
  use({ 'tpope/vim-commentary' })
  use({ 'airblade/vim-rooter' })
  use({ 'andrewradev/tagalong.vim' })
  use({ 'rust-lang/rust.vim' })
  use({ 'jbgutierrez/vim-better-comments' })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ 'neovim/nvim-lspconfig' })
  use({ 'nvim-lua/plenary.nvim' })
  use({ 'mfussenegger/nvim-dap' })
  use({ 'airblade/vim-gitgutter' })
  use({ 'github/copilot.vim' })
  use({ 'wakatime/vim-wakatime' })
  use({ 'neovim/nvim-lspconfig' })
  use({ 'nvim-lua/plenary.nvim' })
  -- use({ 'mfussenegger/nvim-dap' })
  -- use({ 'rcarriga/nvim-dap-ui' })
  -- use({ 'hrsh7th/nvim-cmp' })
  -- use({ 'hrsh7th/cmp-nvim-lsp' })
  -- use({ "williamboman/mason.nvim" })
  -- use({ "williamboman/mason-lspconfig.nvim" })
  use { 'simrat39/rust-tools.nvim', requires = { 'neovim/nvim-lspconfig' } }
end)
