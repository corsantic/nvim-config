return {
  -- dir = "/home/enemo/project/regvim",
  "corsantic/regvim",
  event = "CmdlineEnter", -- Load when entering command line
  config = function()
    require("regvim").setup({
<<<<<<< HEAD
      convert_key = '<Tab>', -- Key to trigger manual conversion in command mode
=======
      convert_key = '<C-e>', -- Key to trigger manual conversion in command mode
>>>>>>> 6561556 (.)
      escape_characters = { "(", ")", "+", "?", "|", "{", "}", "[", "]" },
    })
  end,
}
