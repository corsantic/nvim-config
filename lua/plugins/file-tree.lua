return {

	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				filters = {
					dotfiles = true,
					git_ignored = true,
				},
				renderer = {
					group_empty = true,
					icons = {
						show = {
							folder_arrow = true,
						},
					},
				},
				view = {
					width = 30,
				},
			})

			-- Toggle hidden files and gitignored files with 'H' and 'I' in nvim-tree
			local api = require("nvim-tree.api")

			-- You can use these keybindings inside nvim-tree:
			-- Press 'H' to toggle dotfiles (hidden files like .env, .gitignore)
			-- Press 'I' to toggle gitignored files (like node_modules, bin, obj)
			-- Press 'U' to toggle both at once
		end,
	},
}
