return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "folke/neodev.nvim",
    },

    config = function()
        require("neodev").setup()

        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )
        require("fidget").setup({ notification = { override_vim_notify = false } })
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "html",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        on_init = function(client)
                            local path = client.workspace_folders[1].name
                            if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                                return
                            end

                            -- If i don't have the luarc
                            -- client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                            --     runtime = {
                            --         -- Tell the language server which version of Lua you're using
                            --         -- (most likely LuaJIT in the case of Neovim)
                            --         version = 'LuaJIT'
                            --     },
                            --     -- Make the server aware of Neovim runtime files
                            --     workspace = {
                            --         checkThirdParty = false,
                            --         library = {
                            --             vim.env.VIMRUNTIME
                            --             -- Depending on the usage, you might want to add additional paths here.
                            --             -- "${3rd}/luv/library"
                            --             -- "${3rd}/busted/library",
                            --         }
                            --         -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                            --         -- library = vim.api.nvim_get_runtime_file("", true)
                            --     }
                            -- })
                        end,
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                -- diagnostics = {
                                --     globals = { "vim" }
                                -- }
                            }
                        }
                    }
                end,
            },

        })

        local cmp          = require('cmp')
        local cmp_select   = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = {
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
        }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert(cmp_mappings),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
                { name = 'path' },
            }, {
                { name = 'buffer' },
            })
        })

        -- cmp.setup.cmdline(':', {
        --     mapping = cmp.mapping.preset.cmdline(cmp_mappings),
        --     sources = cmp.config.sources({
        --         { name = 'cmdline' },
        --     })
        -- })
    end
}
