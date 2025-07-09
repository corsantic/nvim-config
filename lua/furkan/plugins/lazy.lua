-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
      -- File tree
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      requires = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
          require("nvim-tree").setup {}
        end,
      },
   
    -- Visualize buffers as tabs
    {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},

    -- Save and load buffers (a session) automatically for each folder
    {
     'rmagatti/auto-session',
      config = function()
        require("auto-session").setup {
          log_level = "error",
          auto_session_suppress_dirs = { "~/", "~/Downloads" },
        }
      end
    },
    -- Comment code
    {
      'terrortylor/nvim-comment',
      config = function()
        require("nvim_comment").setup({ create_mappings = false })
      end
     },

     -- Preview markdown live in web browser
          {
          "nvim-treesitter/nvim-treesitter",
          dependencies = { "OXY2DEV/markview.nvim" },
          lazy = false,

          },
   },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
