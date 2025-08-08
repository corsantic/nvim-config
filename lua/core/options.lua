local opt = vim.opt

opt.encoding = "utf-8" -- set encoding

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- history
opt.swapfile = false
opt.backup = false

-- Enable persistent undo

opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true


opt.list = true       -- show tab characters and trailing whitespace

opt.scrolloff = 8     -- minimum number of lines to keep above and below the cursor
opt.sidescrolloff = 8 --minimum number of columns to keep above and below the cursor

opt.hlsearch = false  -- do not highlight all matches on previous search pattern
opt.incsearch = true  -- incrementally highlight searches as you type


-- line wrapping
opt.wrap = false

-- search settings

opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance

opt.termguicolors = true
opt.colorcolumn = "80"
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

-- set color theme
-- vim.cmd("colorscheme catppuccin-macchiato")
-- vim.cmd("colorscheme rose-pine")

opt.termguicolors = true
opt.updatetime = 50
--bufferline

require("bufferline").setup {}

-- telescope setup
require("telescope").setup {
  pickers = {
    find_files = {
      -- theme = "dropdown",
    },
  }
}

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.py",
  callback = function()
    opt.textwidth = 79
    opt.colorcolumn = "79"
  end
}) -- python formatting

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.js", "*.html", "*.css", "*.lua" },
  callback = function()
    opt.tabstop = 2
    opt.softtabstop = 2
    opt.shiftwidth = 2
  end
}) -- javascript formatting

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal! g`\"")
    end
  end
}) -- return to last edit position when opening files
vim.filetype.add({
  pattern = {
    [".*%.component%.html"] = "htmlangular",
  },
})
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd(":Dotenv ~/.default.env")
    -- resize nvim-tree on startup
    vim.cmd(":NvimTreeResize 40")
  end
})
-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
    desc = "Resize nvim-tree if nvim window got resized",

    group = vim.api.nvim_create_augroup("NvimTreeResize", { clear = true }),
    callback = function()
        local percentage = 15

        local ratio = percentage / 100
        local width = math.floor(vim.go.columns * ratio)
        vim.cmd("tabdo NvimTreeResize " .. width)
    end,
})
