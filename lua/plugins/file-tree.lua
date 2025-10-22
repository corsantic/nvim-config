return {

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        filters = {
          dotfiles = false, -- Show hidden files by default (change to true to hide)
          custom = { "^.git$" }, -- Hide .git folder
        },
        renderer = {
          group_empty = true,
          icons = {
            show = {
              folder_arrow = true,
            },
          },
        },
        view = {
          width = 30,
        },
      }

      -- Toggle hidden files with 'H' in nvim-tree
      vim.keymap.set("n", "H", function()
        require("nvim-tree.api").tree.toggle_hidden_filter()
      end, { desc = "Toggle hidden files in nvim-tree", buffer = true })
    end,
  }
}
