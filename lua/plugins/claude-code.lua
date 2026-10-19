-- Claude Code IDE integration (WebSocket MCP protocol, same as the VS Code extension).
-- No in-editor terminal: Claude runs in tmux and attaches with `/ide` (or `claude --ide`).
-- Loads at startup so the server is up and external sessions can attach.
return {
  "coder/claudecode.nvim",
  event = "VeryLazy",
  opts = {
    terminal = { provider = "none" },
  },
  keys = {
    { "<leader>cs", "<cmd>ClaudeCodeSend<cr>",        mode = "v", desc = "Send selection to Claude" },
    { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add buffer to Claude" },
    { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>",  desc = "Accept Claude diff" },
    { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>",    desc = "Deny Claude diff" },
  },
}
