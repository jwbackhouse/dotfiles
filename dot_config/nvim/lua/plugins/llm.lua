return {
  {
    'copilotlsp-nvim/copilot-lsp',
    enabled = false,
    init = function()
      vim.g.copilot_nes_debounce = 500
      vim.lsp.enable 'copilot'
      vim.keymap.set('n', '<tab>', function()
        require('copilot-lsp.nes').apply_pending_nes()
      end)
    end,
  },
  {
    'olimorris/codecompanion.nvim',
    enabled = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'franco-ruggeri/codecompanion-spinner.nvim',
    },
    config = function()
      local cc = require 'codecompanion'
      cc.setup {
        extensions = { spinner = {} },
        adapters = {
          http = {
            openai = function()
              return require('codecompanion.adapters').extend('openai', {
                env = {
                  api_key = 'cmd:op read "op://Private/OpenAI MCP key/credential"',
                },
              })
            end,
          },
          acp = {
            claude_code = function()
              return require('codecompanion.adapters').extend('claude_code', {
                env = {
                  CLAUDE_CODE_OAUTH_TOKEN = 'cmd:op read "op://Private/Anthropic API key/credential"',
                },
              })
            end,
            gemini_cli = function()
              return require('codecompanion.adapters').extend('gemini_cli', {
                defaults = {
                  auth_method = 'gemini-api-key',
                },
                env = {
                  GEMINI_API_KEY = 'cmd:op read "op://Private/Gemini API Key/credential"',
                },
              })
            end,
          },
        },
        log_level = 'DEBUG',
        strategies = {
          chat = {
            -- adapter = { name = 'copilot', model = 'gpt4.0' },
            adapter = 'claude_code',
            slash_commands = {
              ['file'] = {
                opts = {
                  provider = 'snacks',
                },
              },
            },
            tools = {
              ['next_edit_suggestion'] = {
                opts = {
                  --- the default is to open in a new tab, and reuse existing tabs
                  --- where possible
                  ---@type string|fun(path: string):integer?
                  jump_action = 'tabnew',
                },
              },
              -- ['mcp'] = {
              --   callback = function()
              --     return require 'mcphub.extensions.codecompanion'
              --   end,
              --   opts = {
              --     requires_approval = false,
              --     temperature = 0.7,
              --   },
              -- },
            },
          },
          inline = {
            adapter = 'copilot',
          },
        },
        display = {
          chat = {
            window = {
              width = 0.3,
            },
            icons = {
              chat_context = '📎️',
            },
            fold_context = true,
            fold_reasoning = true,
            start_in_insert_mode = true,
            show_settings = true,
          },
          diff = {
            provider = 'mini_diff',
          },
          action_palette = {
            provider = 'default',
          },
        },
      }

      vim.keymap.set({ 'n', 'v' }, '<D-i>', '<Cmd>CodeCompanionActions<CR>', { noremap = true, silent = true })
      vim.cmd [[cab cc CodeCompanion]] -- map cc to CodeCompanion in command line
    end,
  },
  { 'github/copilot.vim', enabled = false, event = 'VeryLazy' },
  {
    'zbirenbaum/copilot.lua',
    event = 'VeryLazy',
    enabled = true,
    config = true,
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = '<Tab>',
          dismiss = '<C-e>',
        },
      },
    },
  },
  {
    'yetone/avante.nvim',
    build = vim.fn.has 'win32' ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' or 'make',
    event = 'VeryLazy',
    version = false,
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = 'openai',
      auto_suggestions_provider = 'openai',
      providers = {
        morph = {
          model = 'morph-v3-large',
        },
        claude = {
          endpoint = 'https://api.anthropic.com',
          model = 'claude-sonnet-4-20250514',
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 20480,
          },
        },
        copilot = { enabled = false },
      },
      input = {
        provider = 'snacks',
        provider_opts = {
          title = 'Avante Input',
          icon = ' ',
        },
      },
      behaviour = {
        enable_fastapply = true,
      },
      rag_service = {
        enabled = false,
        host_mount = os.getenv 'HOME',
        runner = 'docker',
        llm = {
          provider = 'openai',
          endpoint = 'https://api.openai.com/v1',
          api_key = 'OPENAI_API_KEY',
          model = 'gpt-4o-mini',
          extra = nil,
        },
        embed = {
          provider = 'openai',
          endpoint = 'https://api.openai.com/v1',
          api_key = 'OPENAI_API_KEY',
          model = 'text-embedding-3-large',
          extra = nil,
        },
        docker_extra_args = '',
      },
      system_prompt = function()
        -- local hub = require('mcphub').get_hub_instance()
        -- return hub and hub:get_active_servers_prompt() or ''
      end,
      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require('mcphub.extensions.avante').mcp_tool(),
        }
      end,
      selector = {
        --- @alias avante.SelectorProvider "native" | "fzf_lua" | "mini_pick" | "snacks" | "telescope" | fun(selector: avante.ui.Selector): nil
        --- @type avante.SelectorProvider
        provider = 'snacks',
        -- Options override for custom providers
        provider_opts = {},
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      -- 'stevearc/dressing.nvim', -- for input provider dressing
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      -- 'zbirenbaum/copilot.lua', -- for providers='copilot'
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
}
