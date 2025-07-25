return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      html = { "prettier" },
      htmlangular = { "prettier" },
      scss = { "prettier" },
      json = { "prettier" },
      sql = { "prettier" },
      cs = { "csharpier" },
    },
    formatters = {
      csharpier = {
        command = "csharpier",
        args = {
          "format",
          "--write-stdout"
        },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  }
}
