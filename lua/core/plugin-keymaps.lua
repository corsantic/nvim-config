-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fs', builtin.find_files, {})
vim.keymap.set('n', '<leader>fp', builtin.git_files, {})
vim.keymap.set('n', '<leader>fz', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})


-- tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")

-- markview
vim.keymap.set('n', "<leader>mv", ":Markview<cr>")


-- nvim comment toggle
vim.keymap.set({ 'n', 'v' }, '<leader>/', ":CommentToggle<cr>")


-- format code using LSP
-- vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>fm", function()
  local conform = require("conform")
  local formatted = conform.format({ async = false, quiet = true })
  if not formatted then
    vim.lsp.buf.format()
  end
end, { desc = "Format with Conform or LSP" })

-- fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git);


-- harpoon
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end)


-- dbee
vim.keymap.set("n", "<leader>ce", ":lua require('dbee').toggle()<CR>", { desc = "Toggle DB Explorer" })
