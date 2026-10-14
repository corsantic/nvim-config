-- Claude Code IDE integration (WebSocket MCP protocol, same as the VS Code extension).
-- Loads at startup so the server is up and external sessions can attach via `/ide`.
return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  event = "VeryLazy",
  opts = {
    terminal = {
      split_side = "right",
      split_width_percentage = 0.30,
      snacks_win_opts = {
        keys = {
          claude_hide = { "<M-c>", function(self) self:hide() end, mode = "t", desc = "Hide Claude" },
        },
      },
    },
  },
  keys = {
    { "<M-c>",      "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
    { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
    { "<leader>cs", "<cmd>ClaudeCodeSend<cr>",        mode = "v", desc = "Send selection to Claude" },
    { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add buffer to Claude" },
    { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>",  desc = "Accept Claude diff" },
    { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>",    desc = "Deny Claude diff" },
  },
}
