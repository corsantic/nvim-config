return {
  {
    "awslabs/amazonq.nvim",
    event = "InsertEnter",
    cmd = "AmazonQ",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    opts = {
      ssoStartUrl = "https://view.awsapps.com/start",
      inline_suggest = true,
      -- plugin default list uses "csharp", but nvim's filetype for .cs is "cs"
      filetypes = {
        "amazonq", "bash", "c", "cpp", "cs", "go", "java", "javascript",
        "kotlin", "lua", "python", "ruby", "rust", "sh", "sql", "typescript",
      },
    },
    config = function(_, opts)
      require("amazonq").setup(opts)
    end,
  },
}
