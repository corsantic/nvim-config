return
{
  "johannes-graner/remote-nvim.nvim",
  branch = "fix/pty-argument",          -- Use PR branch with Docker fixes
  dependencies = {
    "nvim-lua/plenary.nvim",            -- For standard functions
    "MunifTanjim/nui.nvim",             -- To build the plugin UI
    "nvim-telescope/telescope.nvim",    -- For picking b/w different remote methods
  },
  config = function()
    require("remote-nvim").setup({
      client_callback = function(port, workspace_config)
        local cmd = ("tmux new-session -d -s remote-nvim 'nvim --server localhost:%s --remote-ui'"):format(port)
        vim.fn.jobstart(cmd, {
          detach = true
        })
      end,
    })
  end,
}
