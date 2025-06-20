return {
  { 'folke/neodev.nvim' },
  { 'akinsho/toggleterm.nvim', version = "*", config = true },
  {
    'chentoast/marks.nvim',
    config = function()
      require('marks').setup({
        default_mappings = true,
        cyclic = true,
      })
    end
  },
  { 'mbbill/undotree' },
  { 'fatih/vim-go' },
  -- {
  -- 'FluxxField/bionic-reading.nvim',
  -- },
  {
    'numToStr/Navigator.nvim',
    config = function()
      require('Navigator').setup({})
    end
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup({})
    end
  },
  { 'windwp/nvim-autopairs',      event = 'InsertEnter', opts = {} },
  { 'yorickpeterse/nvim-window' },
  { 'nvim-tree/nvim-web-devicons' },
  {
    'mrjones2014/smart-splits.nvim',
    config = function()
      require('smart-splits').setup({
        default_amount = 30
      })
    end
  },
  { 'RRethy/nvim-treesitter-endwise' },
  {
    'kazhala/close-buffers.nvim',
    config = function()
      require('close_buffers').setup({
        preserve_window_layout = { 'this', 'nameless' }
      })
    end
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({})
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    }
  },
}
