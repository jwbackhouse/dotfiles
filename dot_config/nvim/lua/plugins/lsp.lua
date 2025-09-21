return {
  {
    'retran/meow.yarn.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
      require('meow.yarn').setup {
        -- Your custom configuration goes here
      }
    end,
  },
  {
    'folke/trouble.nvim',
    opts = {
      -- @type trouble.Window.opts
      win = {
        size = 0.3,
      },
    },
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>xs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>xl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
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
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      -- 'hrsh7th/cmp-nvim-lsp',
      'saghen/blink.cmp',
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      -- After https://www.reddit.com/r/neovim/comments/1hd8qv5/docker_compose_file_not_getting_recognized/
      -- Ensure docker-compose files use the correct filetype for LSP
      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = { 'docker-compose.*.yml', 'docker-compose.*.yaml' },
        callback = function()
          vim.bo.filetype = 'yaml.docker-compose'
        end,
      })

      --  This function gets run when an LSP attaches to a particular buffer.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', ':VtsExec goto_source_definition<CR>', '[G]oto [I]mplementation')

          -- This is a TS-only feature
          map('<leader>dr', ':VtsExec rename_file<CR>', '[D]ocument [R]ename')

          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- Prevent highlighting word under cursor
          vim.lsp.handlers['textDocument/documentHighlight'] = function() end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      local servers = {
        vtsls = {
          settings = {
            vstls = { experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            } },
            typescript = {
              tsserver = {
                nodePath = '~/.config/nvim/run-electron-as-node',
                -- nodePath = '/Applications/Electron.app/Contents/MacOs/Electron',
                maxTsServerMemory = 8192,
              },
              preferences = {
                importModuleSpecifier = 'relative',
              },
            },
          },
        },
        sqlls = {
          cmd = { '/Users/jamesbackhouse/.nvm/versions/node/v18.16.0/bin/sql-language-server', 'up', '--method', 'stdio' },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        docker_language_server = {},
        docker_compose_language_service = {},
        prismals = {},
        emmet_language_server = {},
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'vtsls',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        -- ensure_installed = { 'ts_ls' },
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      -- Additional non-mason server: osocloud
      local lspconfig = require 'lspconfig'
      local configs = require 'lspconfig.configs'
      if not configs.osocloud then
        configs.osocloud = {
          default_config = {
            cmd = { 'oso-cloud', 'lsp' },
            filetypes = { 'polar' },
            root_dir = function(fname)
              return lspconfig.util.find_git_ancestor(fname)
            end,
            settings = {},
          },
        }
      end
      lspconfig.osocloud.setup {}
    end,
  },
  {
    'yioneko/nvim-vtsls',
  },
  {
    'nvimdev/lspsaga.nvim',
    event = 'VeryLazy',
    config = function()
      require('lspsaga').setup {
        lightbulb = {
          sign = false,
          enable = false,
        },
        symbol_in_winbar = {
          enable = false,
        },
        rename = {
          in_select = false,
        },
      }
    end,
  },
}
