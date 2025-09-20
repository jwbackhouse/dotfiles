return {
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'neovim/nvim-lspconfig',
    },
    opts = {},
  },
  {
    'jwbackhouse/tailwind-picker.nvim',
    event = 'VeryLazy',
    dependencies = { 'folke/snacks.nvim' },
    opts = {
      keys = { open = '<leader>ft' },
      scan_depth = 4,
    },
    config = function(_, opts)
      require('tailwind_picker').setup(opts)
    end,
  },
}
