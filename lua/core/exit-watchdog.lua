-- Exit watchdog: an nvim that has started to quit must never outlive its terminal.
-- Must be required BEFORE lazy.nvim: VimLeavePre autocmds run in registration order, and the
-- watchdog has to be armed before any plugin's exit handler can block.

local EXIT_WATCHDOG_DELAY_MS = 10000
local EXIT_WATCHDOG_SIGNAL = "sigkill"

-- Exit can block forever once no UI is left to answer: a "-- More --" or hit-enter prompt
-- for an error raised during exit, or a quit nested inside system() waiting on its own child.
local function arm_exit_watchdog()
	local watchdog = vim.uv.new_timer()
	watchdog:start(EXIT_WATCHDOG_DELAY_MS, 0, function()
		vim.uv.kill(vim.uv.os_getpid(), EXIT_WATCHDOG_SIGNAL)
	end)
end

vim.api.nvim_create_autocmd("VimLeavePre", { callback = arm_exit_watchdog })

-- Quit nvim when all UIs detach (prevents zombie nvim --embed processes)
vim.api.nvim_create_autocmd("UILeave", {
	callback = function()
		if #vim.api.nvim_list_uis() == 0 then
			arm_exit_watchdog()
			vim.cmd("quitall!")
		end
	end,
})
