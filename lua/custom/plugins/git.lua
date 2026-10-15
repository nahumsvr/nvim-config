local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'nvim-lua/plenary.nvim',
  gh 'kdheepak/lazygit.nvim',
  gh 'sindrets/diffview.nvim',
}

require('diffview').setup {
  view = { default = { layout = 'diff2_vertical' } },
  file_history_panel = {},
  default_args = {},
}
-- File history layout lives under `view.file_history`.
require('diffview.config').get_config().view.file_history.layout = 'diff2_vertical'

local map = vim.keymap.set
map('n', '<leader>gj', function() require('gitsigns').nav_hunk 'next' end, { desc = 'Git: next hunk' })
map('n', '<leader>gk', function() require('gitsigns').nav_hunk 'prev' end, { desc = 'Git: previous hunk' })
map('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'Git: LazyGit' })
map('n', '<leader>gv', '<cmd>DiffviewOpen<CR>', { desc = 'Git: view changes (Diffview)' })
map('n', '<leader>gV', '<cmd>DiffviewClose<CR>', { desc = 'Git: close Diffview' })
map('n', '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', { desc = 'Git: current file history' })

require('which-key').add { { '<leader>g', group = '[G]it' } }
