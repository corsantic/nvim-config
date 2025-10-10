-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fs", builtin.find_files, {})
vim.keymap.set("n", "<leader>fp", builtin.git_files, {})
vim.keymap.set("n", "<leader>fz", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fr", builtin.grep_string, {})
vim.keymap.set("n", "<leader>ff", builtin.current_buffer_fuzzy_find, {})
vim.keymap.set("n", "<leader>fd", function()
	builtin.diagnostics({
		bufnr = 0,
	})
end, {})
vim.keymap.set("n", "<leader>fad", function()
	builtin.diagnostics({
		severity= vim.diagnostic.severity.ERROR,
	})
end, {})
-- it was not working in options. TODO: check this and configure it in options.lua for dropdown
vim.keymap.set({ "n", "x" }, "<leader>cc", function()
	require("telescope").extensions.neoclip.default(require("telescope.themes").get_dropdown())
end, {})
vim.keymap.set("n", "<leader>fh", builtin.command_history, {})
vim.keymap.set("n", "<leader>fg", builtin.git_status, {})
vim.keymap.set("n", "<leader>gr", builtin.lsp_references, { noremap = true, silent = true, desc = "References" })
vim.keymap.set("n", "<leader>gd", builtin.lsp_definitions, { noremap = true, silent = true, desc = "Definitions" })
vim.keymap.set("n", "<leader>fx", builtin.resume, { noremap = true, silent = true, desc = "Resume" })

-- tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")

-- markview
vim.keymap.set("n", "<leader>mv", ":Markview<cr>")

-- nvim comment toggle
vim.keymap.set({ "n", "v" }, "<leader>/", ":CommentToggle<cr>")

-- format code using LSP
-- vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>fm", function()
	local conform = require("conform")
	conform.format({
		async = false,
		lsp_fallback = true,
	})
end, { desc = "Format with Conform or LSP" })

-- fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- harpoon
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<leader>1", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<leader>2", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<leader>3", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<leader>4", function()
	harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>hp", function()
	harpoon:list():prev()
end)
vim.keymap.set("n", "<leader>hn", function()
	harpoon:list():next()
end)

-- Copilot
-- vim.g.copilot_no_tab_map = true
-- vim.api.nvim_set_keymap("i", "<C-y>", 'copilot#Accept("<CR>")', { expr = true, silent = true, noremap = true })

-- -- dbee
-- vim.keymap.set("n", "<leader>ce", ":lua require('dbee').toggle()<CR>", { desc = "Toggle DB Explorer" })

-- hop key maps
local hop = require("hop")
local directions = require("hop.hint").HintDirection
vim.keymap.set("", "f", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set("", "F", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set("", "t", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
vim.keymap.set("", "T", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })

-- refactoring
vim.keymap.set("x", "<leader>re", ":Refactor extract ")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")

vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")

vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

vim.keymap.set({ "n", "x" }, "<leader>rI", ":Refactor inline_func")

vim.keymap.set({ "n", "x" }, "<leader>rb", ":Refactor extract_block")
vim.keymap.set({ "n", "x" }, "<leader>rbf", ":Refactor extract_block_to_file")

-- vim bbye
vim.keymap.set("n", "<leader>q", ":Bdelete<cr>")

-- rest-nvim
vim.keymap.set("n", "<leader>tr", ":Rest run<cr>")

-- vimdadbot
vim.keymap.set("n", "<leader>vdb", ":DBUI<cr>")

-- spectre
vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").toggle()<CR>', {
	desc = "Toggle Spectre",
})

vim.keymap.set("n", "<leader>sv", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
	desc = "Search current word",
})

vim.keymap.set("v", "<leader>sv", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
	desc = "Search current word",
})

vim.keymap.set("n", "<leader>sf", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
	desc = "Search on current file",
})

-- gitsigns

require("gitsigns").setup({

	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")
		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end
		map("n", "<leader>gp", gitsigns.preview_hunk)
		map("n", "<leader>g[", gitsigns.preview_hunk_inline)
	end,
})

-- noice
vim.keymap.set("n", "<leader>nl", function()
	require("noice").cmd("last")
end)

vim.keymap.set("n", "<leader>nh", function()
	require("noice").cmd("history")
end)

vim.keymap.set("n", "<leader>nd", function()
	require("noice").cmd("dismiss")
end)
