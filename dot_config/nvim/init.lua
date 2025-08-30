--[[
-- Adapted from TJ DeVries' kickstart.nvim
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.env.PATH = vim.env.PATH .. ':/opt/homebrew/bin:/usr/local/bin'
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- Prevent comments continuing on new line
vim.cmd [[autocmd FileType * set formatoptions-=ro]]
vim.opt.signcolumn = 'number'

-- Folding
vim.opt.foldlevel = 99 -- Start with all folds open
-- Open test files with folding enabled
-- vim.api.nvim_create_autocmd('BufWinEnter', {
--   pattern = { '*' },
--   callback = function()
--     local file_name = vim.fn.expand '%:t'
--     if file_name:match '%.test%.ts$' or file_name:match '%.test%.tsx$' then
--       vim.opt.foldlevel = 2
--       vim.opt.foldnestmax = 6
--     else
--       vim.opt.foldlevel = 99
--     end
--   end,
-- })
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldtext = ''

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.cmd 'autocmd FileType * set number'

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- [[ Basic Keymaps ]]
-- JB keymaps
local default_options = { noremap = true, silent = true }
-- Remap Ctrl-i to move up by half a page
-- vim.api.nvim_set_keymap('n', '<C-i>', '<C-u>', default_options)
-- Map 'jj' to exit insert mode
vim.keymap.set('i', 'jj', '<Esc>', default_options)
-- CmdS save
vim.keymap.set('n', '<D-s>', ':w<CR>', { noremap = true, silent = true, desc = 'Save' })
vim.keymap.set('i', '<D-s>', '<Esc>:w<CR>', { noremap = true, silent = true, desc = 'Save' })
-- Diagnostics
vim.keymap.set('n', '<leader>e', function()
  vim.diagnostic.open_float()
  -- TODO: temporarily toggle tiny-inline-diagnostics
end, default_options)
-- Opens virtual lines but no line wrapping
-- vim.keymap.set('n', '<leader>e', function()
--   vim.diagnostic.config { virtual_lines = { current_line = true }, virtual_text = false }
--   vim.api.nvim_create_autocmd('CursorMoved', {
--     group = vim.api.nvim_create_augroup('line-diagnostics', { clear = true }),
--     callback = function()
--       vim.diagnostic.config { virtual_lines = false, virtual_text = true }
--       return true
--     end,
--   })
-- end)

-- Remove unused imports
vim.keymap.set('n', "<D-S-'>", ':VtsExec remove_unused_imports<CR>', { noremap = true, silent = true, desc = 'Remove unused imports' })
-- Cycle through buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true, desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true, desc = 'Previous buffer' })
-- Lspsaga
vim.keymap.set('n', '<leader>rn', ':Lspsaga rename<CR>', { noremap = true, silent = true, desc = '[R]e[n]ame' })
vim.keymap.set('n', 'gD', ':Lspsaga goto_type_definition<CR>', { noremap = true, silent = true, desc = '[G]oto Type [D]efinition' })
-- Buffers
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { noremap = true, silent = true, desc = '[B]uffer [D]elete' })
vim.keymap.set('n', '<leader>ba', ':bufdo bd<CR>', { noremap = true, silent = true, desc = '[B]uffer close [A]ll' })
-- Tabs
vim.keymap.set('n', '<leader>an', ':tabnew<CR>', { noremap = true, silent = true, desc = 'T[A]b [N]ew' })
vim.keymap.set('n', '<leader>ac', ':tabclose<CR>', { noremap = true, silent = true, desc = 'T[A]b [C]lose' })
vim.keymap.set('n', '<leader>ai', ':tabprevious<CR>', { noremap = true, silent = true, desc = 'T[A]b Previous [I]' })
vim.keymap.set('n', '<leader>ao', ':tabnext<CR>', { noremap = true, silent = true, desc = 'T[A]b Next [O]' })
-- Kitty Navigate Splits
vim.keymap.set('n', '<C-J>', ':KittyNavigateDown <CR>', default_options)
vim.keymap.set('n', '<C-K>', ':KittyNavigateUp <CR>', default_options)
vim.keymap.set('n', '<C-L>', ':KittyNavigateRight <CR>', default_options)
vim.keymap.set('n', '<C-H>', ':KittyNavigateLeft <CR>', default_options)
-- window splits
vim.keymap.set('n', '<leader>wv', ':vs<CR>', { noremap = true, silent = true, desc = '[W]indow [V]ertical split' })
vim.keymap.set('n', '<leader>wh', ':split<CR>', { noremap = true, silent = true, desc = '[W]indow [H]orizontal split' })
-- custom
vim.keymap.set('n', '<leader>cl', function()
  require('custom.utils').quicklog()
end, { noremap = true, silent = true, desc = '[C]ode [L]og' })
-- Lua
vim.keymap.set('n', '<leader>ls', '<cmd>source %<CR>', { noremap = true, silent = true, desc = '[L]ua [S]ource file' })
vim.keymap.set({ 'n', 'v' }, '<leader>lr', ':.lua<CR>', { noremap = true, silent = true, desc = '[L]ua [R]un' })
-- Quickfix
vim.keymap.set('n', '<M-j>', '<cmd>cnext<CR>', { noremap = true, silent = false, desc = 'Quickfix next' })
vim.keymap.set('n', '<M-k>', '<cmd>cprev<CR>', { noremap = true, silent = false, desc = 'Quickfix previous' })
-- Open file in Marta finder
vim.keymap.set('n', '<leader>of', function()
  local cwd = vim.fn.expand '%:p:h' -- Get the directory of the current file
  vim.fn.system { 'open -a Marta', cwd }
end, { desc = '[O]pen in [F]inder' })
-- Context
vim.keymap.set('n', '[c', function()
  require('treesitter-context').go_to_context(vim.v.count1)
end, { noremap = true, silent = true, desc = 'Previous context' })
-- Disable default keymaps
vim.keymap.set('n', '<F1>', '<nop>', { noremap = true, silent = true })
-- Comments
vim.keymap.set('n', '<D-/>', 'gcc', { remap = true, silent = true })
vim.keymap.set('v', '<D-/>', 'gc', { remap = true, silent = true })

-- Original
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = '[D]ocument diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
--
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- File explorer
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        '<leader>-',
        '<cmd>Yazi<cr>',
        desc = 'Open yazi at the current file',
      },
    },
    ---@type YaziConfig
    opts = {
      open_for_directories = true,
      floating_window_scaling_factor = 1,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },
  -- Context aka sticky highlight
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      max_lines = 6,
      trim_scope = 'inner',
      multiline_threshold = 9,
      multiwindow = true,
    },
  },
  -- Scrollbar
  {
    'petertriho/nvim-scrollbar',
    event = 'VeryLazy',
    enabled = false,
    config = function()
      local colors = require('tokyonight.colors').setup()
      require('scrollbar').setup {
        handle = {
          color = colors.bg_highlight,
        },
        marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        },
      }
    end,
  },
  -- Symbols outline
  {
    'hedyhli/outline.nvim',
    lazy = true,
    cmd = { 'Outline', 'OutlineOpen' },
    keys = {
      { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle outline' },
    },
    opts = {
      outline_window = {
        wrap = true,
        -- position = 'right',
        split_command = 'rightbelow vs',
      },
    },
  },
  -- Original
  -- {
  --   'prettier/vim-prettier',
  --   build = 'npm install --frozen-lockfile --production',
  --   cmd = { 'Prettier', 'PrettierAsync' }, -- Lazy-load on specific commands
  --   ft = { 'javascript', 'typescript', 'css', 'html', 'json' }, -- Lazy-load on specific filetypes
  --   config = function()
  --     -- Optional: configure vim-prettier settings
  --     -- vim.g["prettier#config#single_quote"] = 1
  --     -- vim.g["prettier#config#bracket_spacing"] = 0
  --   end,
  -- },
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      preset = 'helix',
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>a', group = 'T[A]b' },
        { '<leader>b', group = '[B]uffer' },
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>f', group = '[F]ile' },
        { '<leader>g', group = '[G]it' },
        { '<leader>h', group = '[H]arpoon' },
        { '<leader>l', group = '[L]ua' },
        { '<leader>p', group = '[P]ersistence' },
        { '<leader>q', group = '[Q]ol' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>w', group = '[W]orkspace' },
      },
    },
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      notify_on_error = true,
      default_format_opts = {
        lsp_format = 'fallback',
      },
      format_on_save = {
        timeout_ms = 500,
      },
      format_after_save = {
        timeout_ms = 2500,
      },

      -- format_on_save = function(bufnr)
      --   return {
      --     timeout_ms = 2500,
      --     -- lsp_format = lsp_format_opt,
      --     lsp_fallback = false,
      --   }
      -- end,
      formatters_by_ft = {
        lua = { 'stylua' },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        sql = { 'sql_formatter' },
      },
    },
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'kristijanhusak/vim-dadbod-completion',
      'rafamadriz/friendly-snippets',
    },
    version = '*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      enabled = function()
        return not vim.tbl_contains({ 'copilot-chat', 'typr' }, vim.bo.filetype) and vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false
      end,
      keymap = { preset = 'default' },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        -- list = { selection = { preselect = true, auto_insert = true } },
        menu = {
          draw = { treesitter = { 'lsp' } },
        },
      },
      cmdline = {
        completion = {
          menu = {
            auto_show = true,
          },
        },
      },
      -- snippets = { preset = 'luasnip' },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev', 'dadbod' },
        providers = {
          lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', score_offset = 100 },
          path = { opts = { show_hidden_files_by_default = true } },
          dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
        },
      },
      signature = { enabled = true, window = { border = 'rounded' } },
    },
    opts_extend = { 'sources.default' },
  },
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    enabled = false,
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load {}
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          -- ['<C-l>'] = cmp.mapping(function()
          --   if luasnip.expand_or_locally_jumpable() then
          --     luasnip.expand_or_jump()
          --   end
          -- end, { 'i', 's' }),
          -- ['<C-h>'] = cmp.mapping(function()
          --   if luasnip.locally_jumpable(-1) then
          --     luasnip.jump(-1)
          --   end
          -- end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'vim-dadbod-completion' },
          { name = 'nvim_lua' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
        formatting = {
          format = lspkind.cmp_format {
            with_text = true,
            mode = 'symbol',
            menu = {
              buffer = '[buf]',
              nvim_lsp = '[LSP]',
              nvim_lua = '[Lua]',
              path = '[path]',
              luasnip = '[snip]',
            },
            maxwidth = 80,
          },
          fields = { 'kind', 'abbr', 'menu' },
          expandable_indicator = true,
        },
      }

      cmp.setup.filetype({ 'sql' }, {
        sources = {
          { name = 'vim-dadbod-completion' },
          { name = 'buffer' },
        },
      })
      cmp.setup.filetype({ 'markdown' }, {
        enabled = false,
      })

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'cmdline' },
          { name = 'path' },
          { name = 'buffer' },
        },
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' },
            },
          },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          -- init_selection = 'gnn',
          node_incremental = '<BS>',
          node_decremental = '<S-BS>',
        },
      },
      ensure_installed = { 'bash', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      auto_install = false,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        -- additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = false, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  { import = 'custom.plugins' },
}, {
  dev = {
    path = '~/.config/nvim/projects',
    patterns = { 'jwbackhouse' },
  },
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      -- cmd = '⌘',
      -- config = '🛠',
      -- event = '📅',
      -- ft = '📂',
      -- init = '⚙',
      -- keys = '🗝',
      -- plugin = '🔌',
      -- runtime = '💻',
      -- require = '🌙',
      -- source = '📄',
      -- start = '🚀',
      -- task = '📌',
      -- lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js', '*.json' },
  group = vim.api.nvim_create_augroup('EslintFixAll', { clear = true }),
  command = 'silent! LspEslintFixAll',
  -- callback = function(args)
  --   if vim.fn.exists 'EslintFixAll' then
  --     vim.cmd 'EslintFixAll'
  --   end
  -- require('conform').format { bufnr = args.buf }
  -- end,
})

require 'custom.settings.appearance'
