-- space bar leader key
vim.g.mapleader = " "

-- buffers
vim.keymap.set("n", "L", ":bn<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "H", ":bp<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bx", ":bd<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bd", ":bd | b#<cr>", { desc = "Close buffer and switch to alternate" })

-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })

-- keep J in place
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines keeping cursor position" })


-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep cursor in middle while moving
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up and center" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })


vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d", { desc = "Delete without yanking" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex mode" })

-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitute word under cursor" })
vim.keymap.set("n", "<leader>mx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

vim.keymap.set("v", "<leader>k", [[:s///g<Left><Left><Left>]], { desc = "Substitute in selection" })

-- copy selected text and open substitute command with copied text
vim.keymap.set("v", "<leader>kr", function()
  -- yank selected text to register 'a'
  vim.cmd('normal! "ay')
  -- get the yanked text
  local yanked_text = vim.fn.getreg('a')
  -- escape special characters for regex
  yanked_text = vim.fn.escape(yanked_text, '/\\')
  -- open substitute command with yanked text
  vim.api.nvim_feedkeys(':%s/' .. yanked_text .. '//g' .. string.rep(vim.api.nvim_replace_termcodes('<Left>', true, false, true), 2), 'n', false)
end, { desc = "Substitute selected text" })



-- Window navigation remaps
-- vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })
-- vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })


-- set wrap and nowrap
vim.keymap.set("n", "<leader>sw", ":set wrap<cr>", { desc = "Enable line wrap" })
vim.keymap.set("n", "<leader>snw", ":set nowrap<cr>", { desc = "Disable line wrap" })


-- show virtual text of diagnostics

vim.keymap.set("n", "<leader>sd", function()
  -- toggle
  local is_visible = vim.diagnostic.config().virtual_text;
  vim.diagnostic.config({
    virtual_text = not is_visible
  })
end, { desc = "Toggle diagnostic virtual text" })
