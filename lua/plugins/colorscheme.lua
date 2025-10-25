return {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"luisiacc/gruvbox-baby",
	},
	{ "rebelot/kanagawa.nvim" },
	{
		"tahayvr/matteblack.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("matteblack")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "storm",
			transparent = true,
		},
	},
	{
		"sainnhe/sonokai",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme sonokai")
		end,
	},
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme gruvbox-material")
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
