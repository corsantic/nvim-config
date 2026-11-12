require("core.exit-watchdog") -- must stay first: its VimLeavePre hook has to run before any plugin's
require("core.lazy")
require("core.options")
require("core.keymaps")
require("core.plugin-keymaps")
require("core.colorscheme-options")
