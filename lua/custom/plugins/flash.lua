local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'folke/flash.nvim' }

-- `s` is free because mini.surround uses the `gs` prefix (see init.lua).
require('flash').setup {}

vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end, { desc = 'Flash jump' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', function() require('flash').treesitter() end, { desc = 'Flash treesitter' })
