return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      html = { "prettier" },
      htmlangular = { "prettier" },
      scss = { "prettier" },
      json = { "prettier" },
      sql = { "sql_formatter" },
      cs = { "csharpier" },
      python = { "black" },
      xml = { "xmlformatter" },
      lua = { "stylua" },
    },
    formatters = {
      prettier = {
        prepend_args = {
          "--print-width", "100",
          "--tab-width", "2",
          "--use-tabs", "false"
        },
      },
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
