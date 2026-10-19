return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPre",
	opts = { -- set to setup table
		filetypes = {
			"*", -- Highlight all files, but customize some others.
			"!snacks_terminal", -- Claude Code terminal: re-highlighting on every output change made typing flicker
			css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
			scss = { rgb_fn = true }, -- Enable parsing rgb(...) functions in scss.
		},
		buftypes = { "!terminal" }, -- never attach to terminal buffers
	},
}
