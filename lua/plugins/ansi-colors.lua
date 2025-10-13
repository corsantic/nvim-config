return {
	"m00qek/baleia.nvim",
	version = "*",
	config = function()
		local baleia = require("baleia").setup({})

		-- Store baleia instance globally for manual usage
		vim.g.baleia = baleia

		-- Automatically apply ANSI colors to DAP console and REPL
		vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
			pattern = { "dapui_console", "dap-repl" },
			callback = function(args)
				vim.schedule(function()
					baleia.automatically(args.buf)
				end)
			end,
		})

		-- Create user command to manually colorize current buffer
		vim.api.nvim_create_user_command("BaleiaColorize", function()
			baleia.automatically(vim.api.nvim_get_current_buf())
		end, {})
	end,
}
