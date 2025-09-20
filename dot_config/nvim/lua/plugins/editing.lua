-- Move line up/down in visual line mode
vim.api.nvim_set_keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-k>', ":m '>-2<CR>gv=gv", { noremap = true, silent = true })

return {}
