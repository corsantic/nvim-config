return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      ["html"] = { "prettier" },
      ["htmlangular"] = { "prettier" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}

-- return {
--   "stevearc/conform.nvim",
--   event = { "BufWritePre" },
--   cmd = { "ConformInfo" },
--   -- This will provide type hinting with LuaLS
--   ---@module "conform"
--   ---@type conform.setupOpts
--   opts = {
--     -- Define your formatters
--     formatters_by_ft = {
--       html = { "prettier" },
--       htmlangular = { "prettier" },
--     },
--     -- Set default options
--     default_format_opts = {
--       lsp_format = "fallback",
--     },
--     -- Set up format-on-save
--     format_on_save = { timeout_ms = 500 },
--     -- Customize formatters
--     formatters = {
--       shfmt = {
--         prepend_args = { "-i", "2" },
--       },
--     },
--   },
--   init = function()
--     -- If you want the formatexpr, here is the place to set it
--     vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
--   end,
-- }
