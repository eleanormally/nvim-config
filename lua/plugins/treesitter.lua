return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        sync_install = false,
        ensure_installed = { 'c', 'lua', 'vim', 'javascript', 'html', 'go', 'graphql' },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        endwise = {
          enable = true,
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>n",
            node_incremental = "n",
            scope_incremental = "e",
            node_decremental = "x",

          },
        },
      })
    end
  },
  {
    'nvim-treesitter/playground'
  }
}
