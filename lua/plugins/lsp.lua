return {

  -- Mason
  {
    'mason-org/mason.nvim',
    tag = 'v1.11.0',
    pin = true,
    lazy = false,
    opts = {},
  },
  {
    'mason-org/mason-lspconfig.nvim',
    tag = 'v1.32.0',
    pin = true,
    lazy = true,
    config = false,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require("luasnip")

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'vim-dadbod-completion' },
          { name = 'luasnip' }, -- For luasnip users.
          { name = 'buffer' },  -- For buffer words.
          { name = 'path' },    -- For file paths.
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif vim.fn.col('.') == 1 or vim.fn.getline('.'):sub(vim.fn.col('.') - 1, vim.fn.col('.') - 1):match('%s') then
              fallback() -- 👈 insert a real tab
            else
              fallback() -- 👈 insert a real tab
            end
          end, { "i", "s" }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback() -- fallback will let your normal Shift-Tab keymap (if any) take over
            end
          end, { "i", "s" }),
        }),
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    tag = 'v1.8.0',
    pin = true,
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'mason-org/mason.nvim' },
      { 'mason-org/mason-lspconfig.nvim' },
    },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = 'yes'
    end,
    config = function()
      local lsp_defaults = require('lspconfig').util.default_config

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
          vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end,
      })

      require('mason-lspconfig').setup({
        ensure_installed = { "ts_ls",
          "lua_ls", "angularls", "html", "zls", "omnisharp",
          "sqlls"
        },
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require('lspconfig')[server_name].setup({
            })
          end,
          ["zls"] = function()
            require("lspconfig").zls.setup({
              settings = {
                zls = {
                  enable_autofix = false,
                  line_break_length = 80,
                  format_on_save = false,
                },
              },
            })
          end,
          ["angularls"] = function()
            require("lspconfig").angularls.setup({
              filetypes = { "typescript" }, -- ✅ important!
              -- You can also set root_dir here if needed
              -- root_dir = require("lspconfig.util").root_pattern("angular.json", "package.json")
            })
          end,
          ["html"] = function()
            require("lspconfig").html.setup({
              filetypes = { "html", "htmlangular" }, -- ✅ important!
              -- You can also set root_dir here if needed
              -- root_dir = require("lspconfig.util").root_pattern("package.json")
            })
          end,
        }
      })
    end
  }
}
