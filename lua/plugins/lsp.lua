return {

  -- Mason
  {
    'mason-org/mason.nvim',
    -- tag = 'v1.11.0',
    -- pin = true,
    lazy = false,
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      }
    },
  },
  {
    'mason-org/mason-lspconfig.nvim',
    -- tag = 'v1.32.0',
    -- pin = true,
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
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require("luasnip")

      cmp.setup({
        sources = {
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'vim-dadbod-completion', priority = 700 },
          { name = 'luasnip', priority = 750 }, -- For luasnip users.
          { name = 'codeium', priority = 500 },
          { name = 'buffer', priority = 500 },  -- For buffer words.
          { name = 'path', priority = 300 },    -- For file paths.
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
          ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() and not cmp.visible() then
              luasnip.expand_or_jump()
            elseif cmp.visible() then
              cmp.select_next_item()
            elseif vim.fn.col('.') == 1 or vim.fn.getline('.'):sub(vim.fn.col('.') - 1, vim.fn.col('.') - 1):match('%s') then
              fallback()
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) and not cmp.visible() then
              luasnip.jump(-1)
            elseif cmp.visible() then
              cmp.select_prev_item()
            else
              fallback() -- fallback will let your normal Shift-Tab keymap (if any) take over
            end
          end, { "i", "s" }),
        }),
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
      })

      -- Cmdline completion for `/` (search)
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Cmdline completion for `:` (commands)
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    -- tag = 'v1.8.0',
    -- pin = true,
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
          -- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
          vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
          -- this one handled by telescope now
          -- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          -- vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end,
      })

      require('mason-lspconfig').setup({
        ensure_installed = {
          "ts_ls",
          "lua_ls", "angularls", "cssls", "emmet_language_server", "zls", "tailwindcss",
          "sqlls", "basedpyright", "elixirls", "rust_analyzer"
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
              filetypes = { "typescript", "html", "htmlangular" },
              root_dir = require("lspconfig.util").root_pattern("angular.json", "project.json", "package.json"),
            })
          end,
          ["ts_ls"] = function()
            require("lspconfig").ts_ls.setup({
              filetypes = { "typescript" },
              root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git"),
              on_attach = function(client)
                -- Only enable formatting
                client.server_capabilities.definitionProvider = true
                client.server_capabilities.referencesProvider = false
                client.server_capabilities.hoverProvider = false
                client.server_capabilities.renameProvider = false
                -- ... disable everything except:
                client.server_capabilities.documentFormattingProvider = true
              end,
            })
          end,
          ["cssls"] = function()
            require("lspconfig").cssls.setup({
              filetypes = { "css", "scss", "sass", "less" },
            })
          end,
          ["emmet_language_server"] = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            require("lspconfig").emmet_language_server.setup({
              filetypes = { "html", "htmlangular", "css", "scss", "sass", "less", "eelixir", "heex", "elixir" },
            })
          end,
          ["tailwindcss"] = function()
            require("lspconfig").tailwindcss.setup({
              filetypes = { "html", "elixir", "eelixir", "heex" },
              init_options = {
                userLanguages = {
                  elixir = "html-eex",
                  eelixir = "html-eex",
                  heex = "html-eex",
                },
              },
              settings = {
                tailwindCSS = {
                  experimental = {
                    classRegex = {
                      'class[:]\\s*"([^"]*)"',
                    },
                  },
                },
              },
            })
          end,
          ["roslyn"] = function()
            require('lspconfig').roslyn.setup({
            })
          end,
          ["basedpyright"] = function()
            require("lspconfig").basedpyright.setup({
              root_dir = require("lspconfig.util").root_pattern("pyproject.toml", "setup.py", "setup.cfg",
                "requirements.txt", ".git"),
              settings = {
                basedpyright = {
                  autoImportCompletions = true,
                  autoSearchPaths = true,
                  diagnosticMode = "workspace",
                  useLibraryCodeForTypes = true,
                  typeCheckingMode = "basic",
                },
              },
            })
          end,
          ["elixirls"] = function()
            require("lspconfig").elixirls.setup({
              filetypes = { "elixir", "eelixir", "heex", "phoenix-heex", "surface" },
            })
          end,
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              settings = {
                Lua = {
                  runtime = {
                    version = "LuaJIT",
                  },
                  diagnostics = {
                    globals = { "vim" },
                  },
                  workspace = {
                    checkThirdParty = false,
                    library = {
                      vim.env.VIMRUNTIME,
                    }
                  },
                  telemetry = {
                    enable = false,
                  },
                  format = {
                    enable = false,
                  },
                },
              },
            })
          end
        }
      })
    end
  }
}
