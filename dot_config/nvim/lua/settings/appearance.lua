-- STATUS COLUMN
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.opt.signcolumn = 'yes'

-- Floating window border
vim.o.winborder = 'rounded'

-- CURSORLINE
-- Show which line your cursor is on
vim.opt.cursorline = false
-- Only highlight the line number of the cursor line
vim.opt.cursorlineopt = 'number'

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor.
-- vim.opt.scrolloff = 0

-- GutterMarks plugin
vim.api.nvim_set_hl(0, 'GutterMarksLocal', { fg = '#7dcfff' })
vim.api.nvim_set_hl(0, 'GutterMarksGlobal', { fg = '#e0af68', bold = true })
vim.api.nvim_set_hl(0, 'GutterMarksSpecial', { fg = '#ff899d', italic = true })
