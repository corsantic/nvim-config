return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "OXY2DEV/markview.nvim" },
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "html", "json", "typescript", "zig" },
        highlight = {
          enable = true
        }
      }
    end,


  }
}
