-- Git-related plugins
return {
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'folke/snacks.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('octo').setup {
        picker = 'snacks',
      }
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    enabled = true,
    opts = {
      numhl = false,
      signcolumn = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'right_align',
        delay = 0,
      },
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
    },
    {
      'isakbm/gitgraph.nvim',
      opts = {
        git_cmd = 'git',
        symbols = {
          merge_commit = 'M',
          commit = '*',
        },
        format = {
          timestamp = '%H:%M:%S %d-%m-%Y',
          fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
        },
        hooks = {
          -- Check diff of a commit
          on_select_commit = function(commit)
            vim.notify('DiffviewOpen ' .. commit.hash .. '^!')
            vim.cmd(':DiffviewOpen ' .. commit.hash .. '^!')
          end,
          -- Check diff from commit a -> commit b
          on_select_range_commit = function(from, to)
            vim.notify('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
            vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
          end,
        },
      },
      keys = {
        {
          '<leader>gg',
          function()
            require('gitgraph').draw({}, { all = true, max_count = 5000 })
          end,
          desc = 'GitGraph - Draw',
        },
      },
    },
    {
      'sindrets/diffview.nvim',
      opts = {
        enhanced_diff_hl = true,
        view = {
          merge_tool = {
            layout = 'diff3_mixed',
          },
        },
      },
    },
  },

  -- Keybindings
  vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', { noremap = true, silent = true, desc = '[G]it [D]iffview' }),
  vim.keymap.set('n', ']h', '<cmd>Gitsigns next_hunk<cr><cr>', { noremap = true, silent = true, desc = '[G]it next hunk' }),
  vim.keymap.set('n', '[h', '<cmd>Gitsigns prev_hunk<cr><cr>', { noremap = true, silent = true, desc = '[G]it previous hunk' }),
  vim.keymap.set('n', '<leader>gu', '<cmd>Gitsigns reset_hunk<cr>', { noremap = true, silent = true, desc = '[G]it [U]ndo hunk' }),
  vim.keymap.set('n', '<leader>gh', '<cmd>Gitsigns preview_hunk<cr>', { noremap = true, silent = true, desc = '[G]it Review [H]unk' }),
  vim.keymap.set('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<cr>', { noremap = true, silent = true, desc = '[T]oggle [B]lame' }),
  -- PRs
  vim.keymap.set('n', '<leader>gps', '<cmd>Octo review<cr>', { noremap = true, silent = true, desc = '[G]it [P]R [S]tart review' }),
  vim.keymap.set('n', '<leader>gpf', '<cmd>Octo review submit<cr>', { noremap = true, silent = true, desc = '[G]it [P]R [F]inish review' }),
  vim.keymap.set('n', '<leader>gpc', '<cmd>Octo comment<cr>', { noremap = true, silent = true, desc = '[G]it [P]R [C]omment' }),
  -- Diffview
  vim.keymap.set('n', '<leader>do', '<cmd>DiffviewOpen<cr>', { noremap = true, silent = true, desc = '[D]iffview [O]pen' }),
  vim.keymap.set('n', '<leader>dc', '<cmd>DiffviewClose<cr>', { noremap = true, silent = true, desc = '[D]iffview [C]lose' }),
}
