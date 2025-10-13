return {
	"akinsho/flutter-tools.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim",
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		require("flutter-tools").setup({
			flutter_path = "/Users/corsantic/flutter/flutter/bin/flutter",
			flutter_lookup_cmd = nil,
			fvm = false,
			widget_guides = { enabled = true },
			lsp = {
				settings = {
					showtodos = true,
					completefunctioncalls = true,
					analysisexcludedfolders = {
						vim.fn.expand("$Home/.pub-cache"),
					},
					renamefileswithclasses = "prompt",
					updateimportsonrename = true,
					enablesnippets = false,
				},
			},
			dev_log = {
				enabled = true,
				filter = function(log_line)
					-- Filter out EGL_emulation and other noisy Android emulator logs
					if log_line:match("EGL_emulation") then
						return false
					end
					if log_line:match("eglCodecCommon") then
						return false
					end
					if log_line:match("app_time_stats") then
						return false
					end
					-- Allow all other logs
					return true
				end,
				notify_errors = true, -- if there is an error whilst running then notify the user
				open_cmd = "botright 15split", -- command to use to open the log buffer
				focus_on_open = false, -- focus on the newly opened log window
			},
			closing_tags = {
				highlight = "ErrorMsg", -- highlight for the closing tag
				prefix = ">", -- character to use for close tag e.g. > Widget
				priority = 10, -- priority of virtual text in current line
				-- consider to configure this when there is a possibility of multiple virtual text items in one line
				-- see `priority` option in |:help nvim_buf_set_extmark| for more info
				enabled = true, -- set to false to disable
			},
			debugger = {
				enabled = true,
				run_via_dap = true,
				exception_breakpoints = {},
				register_configurations = function(paths)
					require("dap").configurations.dart = {
						{
							type = "dart",
							request = "launch",
							name = "Launch flutter",
							dartSdkPath = paths.dart_sdk,
							flutterSdkPath = paths.flutter_sdk,
							program = "${workspaceFolder}/lib/main.dart",
							cwd = "${workspaceFolder}",
							console = "debugConsole",
							-- Enable ANSI colors in console output
							additionalOptions = {
								["--color"] = true,
							},
							-- Force color output
							env = {
								CLICOLOR_FORCE = "1",
								TERM = "xterm-256color",
							},
						},
					}
				end,
			},
		})
	end,
}
