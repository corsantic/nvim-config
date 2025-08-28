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
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                -- even more opts
            }
        }
    },
    pickers = {
        find_files = {
            theme = "ivy",
        },
        lsp_references = {
            theme = "cursor",
            layout_config = {
                width = 0.8,
                height = 0.5,
            },
        },
        buffers = {
            theme = "ivy",
            sort_lastused = true,
        },
        diagnostics = {
            theme = "ivy",
        },
        current_buffer_fuzzy_find = {
            theme = "dropdown",
        },
        command_history = {
            theme = "ivy",
        },
    }
}
require("telescope").load_extension("ui-select")
require("telescope").load_extension("rest")
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

vim.api.nvim_create_autocmd("FileType",  {
      pattern = { "json" },
      callback = function()
        vim.api.nvim_set_option_value("formatprg", "jq", { scope = 'local' })
      end,
}) -- json formatting

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


-- luasnip setup
local luasnip = require('luasnip')
function leave_snippet()
    if
        ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
        and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
        and not luasnip.session.jump_active
    then
        luasnip.unlink_current()
    end
end

-- stop snippets when you leave to normal mode
vim.api.nvim_command([[
    autocmd ModeChanged * lua leave_snippet()
]])


