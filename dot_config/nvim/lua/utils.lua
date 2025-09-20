local M = {}

function M.wordUnderCursor()
  return vim.fn.expand '<cword>'
end

function M.quicklog(opts)
  if not opts then
    opts = { addLineNumber = false }
  end

  local varname = M.wordUnderCursor()
  local logStatement
  local ft = vim.bo.filetype
  local lnStr = ''
  if opts.addLineNumber then
    lnStr = 'L' .. tostring(vim.lineNo '.') .. ' '
  end

  if ft == 'lua' then
    logStatement = 'print("' .. lnStr .. varname .. ':", ' .. varname .. ')'
  elseif ft == 'python' then
    logStatement = 'print("' .. lnStr .. varname .. ': " + ' .. varname .. ')'
  elseif ft == 'javascript' or ft == 'typescript' or ft == 'typescriptreact' or ft == 'javascriptreact' then
    logStatement = 'console.log("' .. lnStr .. varname .. ':", ' .. varname .. ')'
  elseif ft == 'zsh' or ft == 'bash' or ft == 'fish' or ft == 'sh' then
    logStatement = 'echo "' .. lnStr .. varname .. ': $' .. varname .. '"'
  elseif ft == 'applescript' then
    logStatement = 'log "' .. lnStr .. varname .. ': " & ' .. varname
  else
    vim.notify('Quicklog does not support ' .. ft .. ' yet.', vim.logWarn)
    return
  end

  local current_line = vim.fn.line '.'
  vim.api.nvim_buf_set_lines(0, current_line, current_line, false, { logStatement })
  vim.cmd [[normal! j==]] -- move down and indent
end

-- For Kitty scrollback. After https://github.com/folke/dot/blob/3140f4f5720c3cc6b5034c624eb7706f8533a82c/nvim/lua/util/init.lua#L53
function M.colorize()
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.statuscolumn = ''
  vim.wo.signcolumn = 'no'
  vim.opt.listchars = { space = ' ' }

  local buf = vim.api.nvim_get_current_buf()

  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  while #lines > 0 and vim.trim(lines[#lines]) == '' do
    lines[#lines] = nil
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

  vim.b[buf].minianimate_disable = true

  vim.api.nvim_chan_send(vim.api.nvim_open_term(buf, {}), table.concat(lines, '\r\n'))
  vim.keymap.set('n', 'q', '<cmd>qa!<cr>', { silent = true, buffer = buf })
  vim.api.nvim_create_autocmd('TextChanged', { buffer = buf, command = 'normal! G$' })
  vim.api.nvim_create_autocmd('TermEnter', { buffer = buf, command = 'stopinsert' })

  vim.defer_fn(function()
    vim.b[buf].minianimate_disable = false
  end, 2000)
end

return M
