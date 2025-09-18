return {
  -- dir = "/home/enemo/project/chrono.nvim",
  "corsantic/chrono.nvim",
  config = function()
    require("chrono").setup({
      convert_key = '<leader>ec', -- default_config
      date_format ="%Y-%m-%d"
    })
  end
}
