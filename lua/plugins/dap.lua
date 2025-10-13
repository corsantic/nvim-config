return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"jbyuki/one-small-step-for-vimkind",
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
	},
	event = "VeryLazy",
	config = function()
		require("dapui").setup({
			icons = { expanded = "▾", collapsed = "▸" },
			layouts = {
				{
					elements = { "scopes", "breakpoints", "stacks", "watches" },
					size = 40,
					position = "left",
				},
			},
			controls = {
				element = "repl",
				enabled = true,
			},
			element_mappings = {},
			expand_lines = true,
			floating = {
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			force_buffers = true,
			render = {
				indent = 1,
				max_value_lines = 100,
			},
		})
	end,
}
