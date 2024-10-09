-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`

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
        style = "night",
      })
    end
  })
  use({
    'hoob3rt/lualine.nvim',
    requires = { 'ryanoasis/vim-devicons', opt = true },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'catppuccin'
        }
      }
    end
  })
  use {
    'sudoerwx/vim-ray-so-beautiful',
    config = function()
      vim.g.ray_options = {
        theme = 'candy',
        background = 'true',
        darkMode = 'true',
        padding = '32',
        language = 'auto'
      }
    end
  }
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
  use({ 'dart-lang/dart-vim-plugin' })
  use({ 'tpope/vim-commentary' })
  use({ 'airblade/vim-rooter' })
  use({ 'andrewradev/tagalong.vim' })
  use({ 'rust-lang/rust.vim' })
  use({ 'jbgutierrez/vim-better-comments' })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ 'neovim/nvim-lspconfig' })
  use({ 'nvim-lua/plenary.nvim' })
  use({ 'airblade/vim-gitgutter' })
  use({ 'github/copilot.vim' })
  use({ 'wakatime/vim-wakatime' })
  use { 'simrat39/rust-tools.nvim', requires = { 'neovim/nvim-lspconfig' } }
  use({ "iamcco/markdown-preview.nvim" })
  use({ "catppuccin/nvim", as = "catppuccin" })
  use({ "ThePrimeagen/vim-be-good" })
  use({ "mistricky/codesnap.nvim", run = "make" })
  use({ "ray-x/go.nvim" })
  use({ 'udalov/kotlin-vim' })
  use({ "rose-pine/neovim", as = "rose-pine" })
end)
