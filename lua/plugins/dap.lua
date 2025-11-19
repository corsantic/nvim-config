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

		-- Enable detailed DAP logging
		dap.set_log_level("TRACE")

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

		-- Handle DAP errors gracefully to prevent crashes
		local notify = vim.notify
		local throttle = false

		dap.listeners.after.event_output["dap_error_handler"] = function(session, body)
			if body.category == "stderr" then
				if not throttle then
					throttle = true
					vim.schedule(function()
						pcall(function()
							notify("DAP stderr: " .. (body.output or ""), vim.log.levels.WARN)
						end)
						vim.defer_fn(function()
							throttle = false
						end, 100) -- 100ms cooldown
					end)
				end
			end
		end
		-- Prevent crash on adapter disconnect
		dap.listeners.after.disconnect["dap_disconnect_handler"] = function()
			vim.schedule(function()
				vim.notify("DAP disconnected", vim.log.levels.INFO)
			end)
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
				justMyCode = true,
				enableStepFiltering = true,
				stopAtEntry = false,
				logging = {
					moduleLoad = false,
					engineLogging = false,
					browserStdOut = false,
				},
				timeout = 10000,
				program = function()
					-- Auto-build before debugging
					print("Building project...")
					-- Find .csproj file in current directory
					local csproj = vim.fn.glob(vim.fn.getcwd() .. "/*.csproj")
					if csproj == "" then
						vim.schedule(function()
							vim.notify("No .csproj file found in current directory", vim.log.levels.ERROR)
						end)
						return dap.ABORT
					end
					local build_result = vim.fn.system("dotnet build " .. vim.fn.shellescape(csproj) .. " --configuration Debug")
					if vim.v.shell_error ~= 0 then
						vim.schedule(function()
							vim.notify("Build failed:\n" .. build_result, vim.log.levels.ERROR)
						end)
						return dap.ABORT
					end
					print("Build successful!")

					local co = coroutine.running()
					if not co then
						vim.notify("Cannot run outside of coroutine", vim.log.levels.ERROR)
						return dap.ABORT
					end

					require("telescope.builtin").find_files({
						prompt_title = "Select DLL",
						cwd = vim.fn.getcwd() .. "/bin/Debug",
						attach_mappings = function(prompt_bufnr, map)
							local actions = require("telescope.actions")
							actions.select_default:replace(function()
								actions.close(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								if selection and selection.path then
									coroutine.resume(co, selection.path)
								else
									coroutine.resume(co, dap.ABORT)
								end
							end)
							-- Handle cancellation (Escape key)
							map("i", "<Esc>", function()
								actions.close(prompt_bufnr)
								coroutine.resume(co, dap.ABORT)
							end)
							map("n", "<Esc>", function()
								actions.close(prompt_bufnr)
								coroutine.resume(co, dap.ABORT)
							end)
							return true
						end,
					})

					local result = coroutine.yield()
					if result == dap.ABORT then
						vim.notify("Debugging cancelled", vim.log.levels.INFO)
					end
					return result
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
