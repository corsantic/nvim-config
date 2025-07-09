-- space bar leader key
vim.g.mapleader = " "


-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fs', builtin.find_files, { })
vim.keymap.set('n', '<leader>fp', builtin.git_files, { })
vim.keymap.set('n', '<leader>fz', builtin.live_grep, { })
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { })


