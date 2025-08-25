-- space bar leader key
vim.g.mapleader = " "

-- buffers
vim.keymap.set("n", "L", ":bn<cr>")
vim.keymap.set("n", "H", ":bp<cr>")
vim.keymap.set("n", "<leader>bx", ":bd<cr>")
vim.keymap.set("n", "<leader>bd", ":bd | b#<cr>")

-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- keep J in place
vim.keymap.set("n", "J", "mzJ`z")


-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep curson in middle while moving
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])


vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

vim.keymap.set("n", "Q", "<nop>")

-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>mx", "<cmd>!chmod +x %<CR>", { silent = true })


-- Window navigation remaps
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
