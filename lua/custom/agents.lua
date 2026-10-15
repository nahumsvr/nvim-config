-- Keymaps for working with coding agents.

-- Visual Y: copy selection to the clipboard as markdown:
--   @path:start:end
--   ```lang
--   code
--   ```
vim.keymap.set('x', 'Y', function()
  local a, b = vim.fn.line 'v', vim.fn.line '.'
  local first, last = math.min(a, b), math.max(a, b)
  local lines = vim.api.nvim_buf_get_lines(0, first - 1, last, false)
  local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
  local text = string.format('@%s:%d:%d\n```%s\n%s\n```', path, first, last, vim.bo.filetype, table.concat(lines, '\n'))
  vim.fn.setreg('+', text)
  vim.api.nvim_feedkeys(vim.keycode '<Esc>', 'nx', false)
  vim.notify(string.format('Copied @%s:%d:%d', path, first, last))
end, { desc = 'Copy selection as agent markdown' })

-- Delete/change never touch the registers (black hole).
for _, mode in ipairs { 'n', 'x' } do
  for _, key in ipairs { 'd', 'D', 'c', 'C' } do
    vim.keymap.set(mode, key, '"_' .. key, { desc = 'Black hole ' .. key })
  end
  vim.keymap.set(mode, '<Del>', '"_x', { desc = 'Black hole delete char' })
  -- Cut to the system clipboard.
  vim.keymap.set(mode, '<leader>d', '"+d', { desc = 'Cut to clipboard' })
  vim.keymap.set(mode, '<leader>D', '"+D', { desc = 'Cut line end to clipboard' })
end
