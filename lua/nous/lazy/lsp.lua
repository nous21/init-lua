return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                },
            })

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "gopls", },
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config("gopls", { capabilities = capabilities })
            vim.lsp.enable("gopls")

            vim.lsp.config("lua_ls", { capabilities = capabilities, cmd = { "lua-language-server" } })
            vim.lsp.enable("lua_ls")

            vim.lsp.config("nixd", {
                capabilities = capabilities,
                cmd = { "nixd" },
                settings = {
                    nixd = {
                        nixpkgs = {
                            expr = "import <nixpkgs> { }",
                        },
                        formatting = {
                            command = { "alejandra" },
                        },
                    },
                },
            })
            vim.lsp.enable("nixd")
        end,
    },

    {
        "nvim-java/nvim-java",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "MunifTanjim/nui.nvim",
            "mfussenegger/nvim-dap",
        },
        config = function()
            vim.lsp.config("jdtls", {
                cmd = { "jdtls" },
            })
            require("java").setup({
                jdk = { auto_install = false },
            })
            vim.lsp.enable("jdtls")
        end,
    },
}
