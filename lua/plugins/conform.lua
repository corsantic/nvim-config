return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      html = { "prettier" },
      htmlangular = { "prettier" },
      scss = { "prettier" },
      json = { "prettier" },
    },
    formatters = {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  }
}
