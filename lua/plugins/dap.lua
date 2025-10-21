return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"jbyuki/one-small-step-for-vimkind",
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
		"Cliffback/netcoredbg-macOS-arm64.nvim",
	},
	event = "VeryLazy",
	config = function()
		local dap = require("dap")

		-- .NET/C# configuration using netcoredbg ARM64
		dap.adapters.coreclr = {
			type = "executable",
			command = os.getenv("HOME") .. "/.local/share/nvim/lazy/netcoredbg-macOS-arm64.nvim/netcoredbg/netcoredbg",
			args = { "--interpreter=vscode" },
		}

		-- Kill process on debug stop
		dap.listeners.after.event_terminated.cleanup = function(session)
			if session and session.config and session.config.pid then
				vim.fn.system("kill -9 " .. session.config.pid)
			end
		end
		dap.listeners.after.event_exited.cleanup = function(session)
			if session and session.config and session.config.pid then
				vim.fn.system("kill -9 " .. session.config.pid)
			end
		end

		-- Keybinding to toggle DAP UI
		vim.keymap.set("n", "<leader>du", function()
			require("dapui").toggle()
		end, { desc = "Toggle DAP UI" })

		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "launch - netcoredbg",
				request = "launch",
				program = function()
					local co = coroutine.running()
					require("telescope.builtin").find_files({
						prompt_title = "Select DLL",
						cwd = vim.fn.getcwd() .. "/bin/Debug",
						attach_mappings = function(prompt_bufnr, map)
							local actions = require("telescope.actions")
							actions.select_default:replace(function()
								actions.close(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								coroutine.resume(co, selection.path)
							end)
							return true
						end,
					})
					return coroutine.yield()
				end,
				env = function()
					-- Try to read launchSettings.json
					local launch_settings = vim.fn.getcwd() .. "/Properties/launchSettings.json"
					if vim.fn.filereadable(launch_settings) == 1 then
						local content = vim.fn.readfile(launch_settings)
						local json_str = table.concat(content, "\n")
						local ok, settings = pcall(vim.json.decode, json_str)

						if ok and settings.profiles and settings.profiles.http then
							local profile = settings.profiles.http
							local env = vim.tbl_extend("force", {}, profile.environmentVariables or {})
							env.ASPNETCORE_URLS = profile.applicationUrl
							return env
						end
					end

					-- Fallback
					return {
						ASPNETCORE_ENVIRONMENT = "Development",
						ASPNETCORE_URLS = "http://localhost:5056",
					}
				end,
			},
		}

		require("dapui").setup({
			icons = { expanded = "▾", collapsed = "▸" },
			layouts = {
				{
					elements = { "scopes", "breakpoints", "stacks", "watches" },
					size = 40,
					position = "left",
				},
				{
					elements = { "repl" },
					size = 10,
					position = "bottom",
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
