-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fs", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fp", builtin.git_files, { desc = "Find git files" })
local function live_grep_type()
	vim.ui.input({ prompt = "Search (append type:go or type:ts): " }, function(input)
		if not input or input == "" then
			return
		end

		-- detect pattern like:  type:go
		local ftype = string.match(input, "type:(%w+)")
		local search = input:gsub("type:%w+", ""):gsub("%s+$", "")

		builtin.live_grep({
			default_text = search,
			additional_args = function()
				if ftype then
					return { "--glob=*." .. ftype }
				end
				return {}
			end,
		})
	end)
end

vim.keymap.set("n", "<leader>ft", live_grep_type, { desc = "Smart live grep with filetype filter" })
vim.keymap.set("n", "<leader>fz", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Old files" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fr", builtin.grep_string, { desc = "Grep string" })
vim.keymap.set("n", "<leader>ff", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy find in buffer" })
vim.keymap.set("n", "<leader>fd", function()
	builtin.diagnostics({
		bufnr = 0,
	})
end, { desc = "Buffer diagnostics" })
vim.keymap.set("n", "<leader>fad", function()
	builtin.diagnostics({
		severity = vim.diagnostic.severity.ERROR,
	})
end, { desc = "All diagnostics (errors)" })
-- it was not working in options. TODO: check this and configure it in options.lua for dropdown
vim.keymap.set({ "n", "x" }, "<leader>cc", function()
	require("telescope").extensions.neoclip.default(require("telescope.themes").get_dropdown())
end, { desc = "Clipboard history" })
vim.keymap.set("n", "<leader>fh", builtin.command_history, { desc = "Command history" })
vim.keymap.set("n", "<leader>fg", builtin.git_status, { desc = "Git status" })
-- Custom handler to deduplicate LSP references and show in Telescope
local function lsp_references_dedupe()
	local params = vim.lsp.util.make_position_params(0, "utf-8")

	vim.lsp.buf_request(
		0,
		"textDocument/references",
		vim.tbl_extend("force", params, {
			context = { includeDeclaration = false },
		}),
		function(err, result, ctx, config)
			if err then
				vim.notify("Error getting references: " .. tostring(err), vim.log.levels.ERROR)
				return
			end

			if not result or vim.tbl_isempty(result) then
				vim.notify("No references found", vim.log.levels.INFO)
				return
			end

			-- Deduplicate based on uri, range.start.line, and range.start.character
			local seen = {}
			local deduplicated = {}

			for _, ref in ipairs(result) do
				local key =
					string.format("%s:%d:%d", ref.uri or ref.targetUri, ref.range.start.line, ref.range.start.character)

				if not seen[key] then
					seen[key] = true
					table.insert(deduplicated, ref)
				end
			end

			-- Convert to items and show in Telescope
			local items = vim.lsp.util.locations_to_items(deduplicated, "utf-8")

			local conf = require("telescope.config").values
			require("telescope.pickers")
				.new(
					require("telescope.themes").get_cursor({
						layout_config = {
							width = 0.8,
							height = 0.5,
						},
						initial_mode = "normal",
					}),
					{
						prompt_title = "LSP References (Deduplicated)",
						finder = require("telescope.finders").new_table({
							results = items,
							entry_maker = require("telescope.make_entry").gen_from_quickfix(),
						}),
						previewer = conf.qflist_previewer({}),
						sorter = conf.generic_sorter({}),
					}
				)
				:find()
		end
	)
end

vim.keymap.set(
	"n",
	"<leader>gr",
	lsp_references_dedupe,
	{ noremap = true, silent = true, desc = "References (deduplicated)" }
)
vim.keymap.set("n", "<leader>gd", builtin.lsp_definitions, { noremap = true, silent = true, desc = "Definitions" })
vim.keymap.set("n", "<leader>fx", builtin.resume, { noremap = true, silent = true, desc = "Resume" })
vim.keymap.set("n", "<leader>?", builtin.keymaps, { noremap = true, silent = true, desc = "Keymaps" })
-- tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>", { desc = "Toggle file tree" })

-- markview
vim.keymap.set("n", "<leader>mv", ":Markview<cr>", { desc = "Toggle Markview" })

-- nvim comment toggle
vim.keymap.set({ "n", "v" }, "<leader>/", ":CommentToggle<cr>", { desc = "Toggle comment" })

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
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Fugitive" })

-- harpoon
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "Harpoon Add" })
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon UI" })

vim.keymap.set("n", "<leader>1", function()
	harpoon:list():select(1)
end, { desc = "Harpoon 1" })
vim.keymap.set("n", "<leader>2", function()
	harpoon:list():select(2)
end, { desc = "Harpoon 2" })
vim.keymap.set("n", "<leader>3", function()
	harpoon:list():select(3)
end, { desc = "Harpoon 3" })
vim.keymap.set("n", "<leader>4", function()
	harpoon:list():select(4)
end, { desc = "Harpoon 4" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>hp", function()
	harpoon:list():prev()
end, { desc = "Harpoon previous" })
vim.keymap.set("n", "<leader>hn", function()
	harpoon:list():next()
end, { desc = "Harpoon next" })

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
end, { remap = true, desc = "Hop forward to char" })
vim.keymap.set("", "F", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true, desc = "Hop backward to char" })
vim.keymap.set("", "t", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true, desc = "Hop forward till char" })
vim.keymap.set("", "T", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true, desc = "Hop backward till char" })

-- refactoring
vim.keymap.set("x", "<leader>re", ":Refactor extract ", { desc = "Refactor extract" })
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ", { desc = "Refactor extract to file" })

vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ", { desc = "Refactor extract variable" })

vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var", { desc = "Refactor inline variable" })

vim.keymap.set({ "n", "x" }, "<leader>rI", ":Refactor inline_func", { desc = "Refactor inline function" })

vim.keymap.set({ "n", "x" }, "<leader>rb", ":Refactor extract_block", { desc = "Refactor extract block" })
vim.keymap.set(
	{ "n", "x" },
	"<leader>rbf",
	":Refactor extract_block_to_file",
	{ desc = "Refactor extract block to file" }
)

-- vim bbye
vim.keymap.set("n", "<leader>q", ":Bdelete<cr>", { desc = "Delete buffer" })

-- rest-nvim
vim.keymap.set("n", "<leader>tr", ":Rest run<cr>", { desc = "Run REST request" })

-- vimdadbot
vim.keymap.set("n", "<leader>vdb", ":DBUI<cr>", { desc = "Open database UI" })

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
		map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview git hunk" })
		map("n", "<leader>g[", gitsigns.preview_hunk_inline, { desc = "Preview git hunk inline" })
	end,
})

-- noice
vim.keymap.set("n", "<leader>nl", function()
	require("noice").cmd("last")
end, { desc = "Noice last message" })

vim.keymap.set("n", "<leader>nh", function()
	require("noice").cmd("history")
end, { desc = "Noice message history" })

vim.keymap.set("n", "<leader>nd", function()
	require("noice").cmd("dismiss")
end, { desc = "Noice dismiss messages" })

-- smart-split
--
-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
local smart_split = require("smart-splits")
vim.keymap.set("n", "<C-A-h>", smart_split.resize_left, { desc = "Resize split left" })
vim.keymap.set("n", "<F8>", smart_split.resize_down, { desc = "Resize split down" })
vim.keymap.set("n", "<F9>", smart_split.resize_up, { desc = "Resize split up" })
vim.keymap.set("n", "<C-A-l>", smart_split.resize_right, { desc = "Resize split right" })
-- moving between splits
vim.keymap.set("n", "<C-h>", smart_split.move_cursor_left, { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", smart_split.move_cursor_down, { desc = "Move to split below" })
vim.keymap.set("n", "<C-k>", smart_split.move_cursor_up, { desc = "Move to split above" })
vim.keymap.set("n", "<C-l>", smart_split.move_cursor_right, { desc = "Move to right split" })
vim.keymap.set("n", "<C-\\>", smart_split.move_cursor_previous, { desc = "Move to previous split" })
-- swapping buffers between windows
vim.keymap.set("n", "<leader><leader>h", smart_split.swap_buf_left, { desc = "Swap buffer left" })
vim.keymap.set("n", "<leader><leader>j", smart_split.swap_buf_down, { desc = "Swap buffer down" })
vim.keymap.set("n", "<leader><leader>k", smart_split.swap_buf_up, { desc = "Swap buffer up" })
vim.keymap.set("n", "<leader><leader>l", smart_split.swap_buf_right, { desc = "Swap buffer right" })
