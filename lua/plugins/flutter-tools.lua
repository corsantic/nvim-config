return {
	"akinsho/flutter-tools.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim",
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
						}
					}
				end,
			},
		})
	end,
}
