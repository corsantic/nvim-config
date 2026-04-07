return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "OXY2DEV/markview.nvim" },
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({})
			require("nvim-treesitter").install({
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"html",
				"angular",
				"json",
				"typescript",
				"javascript",
				"css",
				"scss",
				"zig",
				"c_sharp",
				"elixir",
				"python",
				"heex",
				"http",
				"dart",
				"go",
				"rust",
			})
		end,
	},
}
