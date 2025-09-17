return {

  "rmagatti/auto-session",
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { "~/", "~/Downloads", "/" },
    allowed_dirs = { "~/Projects/*", "~/.config/*" },
    -- log_level = 'debug',

    post_restore_cmds = {
      function()
        -- Restore nvim-tree after a session is restored
        local nvim_tree_api = require("nvim-tree.api")
        nvim_tree_api.tree.open()
        nvim_tree_api.tree.change_root(vim.fn.getcwd())
        nvim_tree_api.tree.reload()
      end,
    },
  },
}
