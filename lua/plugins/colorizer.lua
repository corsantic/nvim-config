return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPre",
	opts = { -- set to setup table
		filetypes = {
			"*", -- Highlight all files, but customize some others.
			css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
			scss = { rgb_fn = true }, -- Enable parsing rgb(...) functions in scss.
		},
	},
}
