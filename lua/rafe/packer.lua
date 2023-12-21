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
    "kaicataldo/material.vim",
    as = "material",
    branch = "main",
    config = function()
      vim.g.material_theme_style = "ocean-community"
      vim.cmd("colorscheme material")
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
  use({ 'vim-airline/vim-airline' })
  use({ 'dart-lang/dart-vim-plugin' })
  use({ 'tpope/vim-commentary' })
  use({ 'airblade/vim-rooter' })
  use({ 'andrewradev/tagalong.vim' })
  use({ 'rust-lang/rust.vim' })
  use({ 'jbgutierrez/vim-better-comments' })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ 'neovim/nvim-lspconfig' })
  use({ 'simrat39/rust-tools.nvim' })
  use({ 'nvim-lua/plenary.nvim' })
  use({ 'mfussenegger/nvim-dap' })
  use({ 'airblade/vim-gitgutter' })
  use({ 'github/copilot.vim' })
end)
