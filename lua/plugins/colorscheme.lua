return {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"luisiacc/gruvbox-baby",
	},
	{ "rebelot/kanagawa.nvim" },
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				-- Your config here
			})
		end,
	},
	{
		"navarasu/onedark.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("onedark").setup({
				style = "darker",
			})
			-- Enable theme
			require("onedark").load()
		end,
	},
}
