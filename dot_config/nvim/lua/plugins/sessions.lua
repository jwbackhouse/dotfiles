return {
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    keys = {
      { '<leader>ps', '<cmd>lua require("persistence").load()<cr>', desc = '[P]ersistence [S]ession Load' },
      { '<leader>pS', '<cmd>lua require("persistence").select()<cr>', desc = '[P]ersistence [S]ession Select' },
      { '<leader>pl', '<cmd>lua require("persistence").load({ last = true })<cr>', desc = '[P]ersistence [L]ast Session Load' },
      { '<leader>pd', '<cmd>lua require("persistence").stop()<cr>', desc = '[P]ersistence [D]isable Persistence' },
    },
    opts = {
      dir = vim.fn.stdpath 'state' .. '/sessions/',
      options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
      need = 0,
      branch = true,
      pre_save = function()
        -- Save the current buffer before saving the session
        vim.cmd 'silent! write'
      end,
    },
  },
}
