return {
  { "nvim-treesitter/nvim-treesitter-refactor" },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "OXY2DEV/markview.nvim" },
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed =
        {
          "lua", "vim", "vimdoc", "query", "markdown",
          "markdown_inline", "html", "json", "typescript", "zig", "c_sharp"
        },
        highlight = {
          enable = true
        },
        refactor = {
          -- highlight_current_scope = { enable = true },
          highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true
          },
        },
      }
    end,
  }
}
