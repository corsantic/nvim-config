return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "luisiacc/gruvbox-baby",
  },
  {"rebelot/kanagawa.nvim"},
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      vim.cmd("colorscheme rose-pine")
    end
  }
}

