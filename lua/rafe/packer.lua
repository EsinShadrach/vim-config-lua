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
  use({ "b0o/incline.nvim" })
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
  use({ 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } })
  use({ 'nvim-treesitter/playground' })
  use({ 'theprimeagen/harpoon' })
  use({ 'mbbill/undotree' })
  use({ 'tpope/vim-fugitive' })
  use({ 'neoclide/coc.nvim', branch = "release" })
  use({ 'jiangmiao/auto-pairs' })
  use({ "ap/vim-css-color" })
  use({ "tpope/vim-surround" })
  use({ 'dart-lang/dart-vim-plugin' })
  use({ 'tpope/vim-commentary' })
  use({ 'airblade/vim-rooter' })
  use({ 'andrewradev/tagalong.vim' })
  use({ 'rust-lang/rust.vim' })
  use({ 'jbgutierrez/vim-better-comments' })
  use({ "nvimdev/indentmini.nvim" })
  use({ "marko-cerovac/material.nvim" })
  use({ 'neovim/nvim-lspconfig' })
  use({ 'nvim-lua/plenary.nvim' })
  use({ 'airblade/vim-gitgutter' })
  use({ 'wakatime/vim-wakatime' })
  use { 'simrat39/rust-tools.nvim', requires = { 'neovim/nvim-lspconfig' } }
  use({ "iamcco/markdown-preview.nvim" })
  -- Themes
  use({ "catppuccin/nvim", as = "catppuccin" })
  use({ 'udalov/kotlin-vim' })
  use({ "rose-pine/neovim", as = "rose-pine" })
  use({ 'navarasu/onedark.nvim' })
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
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
  })

  -- AI Support
  use({ 'stevearc/dressing.nvim' })
  use({ 'MunifTanjim/nui.nvim' })
  use({ 'MeanderingProgrammer/render-markdown.nvim' })
  use {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({})
    end,
  }

  -- Optional dependencies
  use({ 'hrsh7th/nvim-cmp' })
  use({ 'nvim-tree/nvim-web-devicons' }) -- or use 'echasnovski/mini.icons'
  use({ 'HakonHarnes/img-clip.nvim' })
  use({ 'zbirenbaum/copilot.lua' })

  -- Avante.nvim with build process
  use {
    'yetone/avante.nvim',
    branch = 'main',
    run = 'make',
    config = function()
      require('avante').setup()
    end
  }
end)
