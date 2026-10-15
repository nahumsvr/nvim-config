local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'stevearc/oil.nvim' }

require('oil').setup {
  default_file_explorer = true,
  use_default_keymaps = false,
  view_options = { show_hidden = true },
  float = {
    padding = 2,
    max_width = 98,
    max_height = 36,
    border = 'rounded',
  },
  keymaps = {
    ['g?'] = { 'actions.show_help', mode = 'n' },
    ['q'] = { 'actions.close', mode = 'n' },
    ['<Esc>'] = { 'actions.close', mode = 'n' },
    ['<C-c>'] = { 'actions.close', mode = 'n' },
    ['<CR>'] = 'actions.select',
    ['-'] = { 'actions.parent', mode = 'n' },
    ['_'] = { 'actions.open_cwd', mode = 'n' },
    ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
    ['<C-p>'] = 'actions.preview',
    ['<C-r>'] = 'actions.refresh',
    ['gx'] = 'actions.open_external',
  },
}

vim.keymap.set('n', '<leader>e', function() require('oil').toggle_float() end, { desc = 'Open file [E]xplorer (oil)' })

-- Copy the path (relative to cwd) of the current file; in oil, of the entry under the cursor.
vim.keymap.set('n', '<leader>fy', function()
  local path
  if vim.bo.filetype == 'oil' then
    local oil = require 'oil'
    local entry, dir = oil.get_cursor_entry(), oil.get_current_dir()
    if not (entry and dir) then return end
    path = dir .. entry.name
  else
    path = vim.api.nvim_buf_get_name(0)
  end
  if path == '' then return end
  path = vim.fn.fnamemodify(path, ':.')
  vim.fn.setreg('+', path)
  vim.notify('Copied ' .. path)
end, { desc = '[F]ile [Y]ank relative path' })

-- oil moves files with `dd` + `p` through the unnamed register, so the black-hole
-- remaps from custom/agents.lua must not apply inside oil buffers.
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'oil',
  callback = function(args)
    for _, key in ipairs { 'd', 'D', 'c', 'C', '<Del>' } do
      vim.keymap.set({ 'n', 'x' }, key, key, { buffer = args.buf, remap = false })
    end
  end,
})
