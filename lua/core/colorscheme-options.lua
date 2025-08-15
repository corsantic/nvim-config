-- set color theme
-- vim.cmd("colorscheme catppuccin-macchiato")




-- rosepine
visual_color = "#a8a8a8";
require("rose-pine").setup({
  variant = "auto",      -- auto, main, moon, or dawn
  dark_variant = "main", -- main, moon, or dawn
  dim_inactive_windows = false,
  extend_background_behind_borders = true,

  enable = {
    terminal = true,
    legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
    migrations = true,        -- Handle deprecated options automatically
  },

  styles = {
    bold = true,
    italic = false,
    transparency = false,
  },

  groups = {
    border = "muted",
    link = "iris",
    panel = "surface",

    error = "love",
    hint = "iris",
    info = "foam",
    note = "pine",
    todo = "rose",
    warn = "gold",

    git_add = "foam",
    git_change = "rose",
    git_delete = "love",
    git_dirty = "rose",
    git_ignore = "muted",
    git_merge = "iris",
    git_rename = "pine",
    git_stage = "iris",
    git_text = "rose",
    git_untracked = "subtle",

    h1 = "iris",
    h2 = "foam",
    h3 = "rose",
    h4 = "gold",
    h5 = "pine",
    h6 = "foam",
  },

  palette = {
    -- Override the builtin palette per variant
    moon = {
      base = '#18191a',
      overlay = '#363738',
    },
  },

  -- NOTE: Highlight groups are extended (merged) by default. Disable this
  -- per group via `inherit = false`
  highlight_groups = {
    -- MatHighlight = { fg = "#a442f5", bold = false },
    AtStatement = { fg = "#00afff", italic = true },
    StatusLine = { fg = "gold", bg = "rose", blend = 15 },
    -- Comment = { fg = "foam" },
    -- VertSplit = { fg = "muted", bg = "muted" },
    Visual = { fg = "", bg = visual_color, inherit = false, blend = 25 },
  },

  before_highlight = function(group, highlight, palette)
    -- Disable all undercurls
    -- if highlight.undercurl then
    --     highlight.undercurl = false
    -- end
    --
    -- Change palette colour
    -- if highlight.fg == palette.pine then
    --     highlight.fg = palette.foam
    -- end
  end,
})

-- kanagawa
-- Default options:
require('kanagawa').setup({
  compile = false,  -- enable compiling the colorscheme
  undercurl = true, -- enable undercurls
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = false },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = false,   -- do not set background color
  dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
  colors = {             -- add/modify theme and palette colors
    palette = {},
    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  },
  overrides = function(colors) -- add/modify highlights
    return {
    }
  end,
  theme = "wave",    -- Load "wave" theme
  background = {     -- map the value of 'background' option to a theme
    dark = "wave", -- try "dragon" !
    light = "lotus"
  },
})

vim.cmd("colorscheme kanagawa")

-- vim.cmd("colorscheme rose-pine-main")
-- vim.cmd("colorscheme rose-pine-moon")
-- vim.cmd("colorscheme rose-pine-dawn")
--
-- Add match patterns to HTML files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*.html",
  callback = function()
    -- Highlight mat-* attributes
    -- vim.fn.matchadd("MatHighlight", [[\v(mat-[a-zA-Z0-9:_-]+)]])
    -- Highlight @if, @else, etc.
    vim.fn.matchadd("AtStatement", [[@\%(if\|else\|elseif\|foreach\|for\|while\|endif\|endforeach\|endfor\|endwhile\)]])
  end,
})
