return {
  -- dir = "/home/enemo/project/regvim",
  "corsantic/regvim",
  event = "CmdlineEnter",             -- Load when entering command line
  config = function()
    require("regvim").setup({
      convert_key = '<Tab>', -- Key to trigger manual conversion in command mode
    })
  end,
}
