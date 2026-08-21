return {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
        -- TEMPORARY: debug logging to diagnose "-32000: Sequence contains more
        -- than one element" on LSP restart. Writes ~/.local/state/nvim/roslyn.log.
        -- Remove once diagnosed.
        debug = false,
    },
}
