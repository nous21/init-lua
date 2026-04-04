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
            nixpkgs = { expr = "import <nixpkgs> { }" },
            formatting = { command = { "alejandra" } },
        },
    },
})
vim.lsp.enable("nixd")

vim.lsp.config("jdtls", { cmd = { "jdtls" } })
vim.lsp.enable("jdtls")

require("flutter-tools").setup({})
