return {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    init = function()
        vim.env.DOTNET_ROOT = "/usr/local/share/dotnet"
    end,
    opts = {},
}
