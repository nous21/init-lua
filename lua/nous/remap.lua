vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>")

vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "Format code" })

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

-- Java
vim.api.nvim_create_user_command("SpringRun", function()
    vim.cmd("terminal ./mvnw spring-boot:run")
end, {})

vim.api.nvim_create_user_command("SpringDebug", function()
    vim.cmd(
    [[terminal ./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005"]])
end, {})

vim.api.nvim_create_user_command("SpringStop", function()
    vim.cmd("bd!")
end, {})

vim.api.nvim_create_user_command("MvnClean", function()
    vim.cmd("terminal ./mvnw clean")
end, {})

vim.api.nvim_create_user_command("MvnInstall", function()
    vim.cmd("terminal ./mvnw clean install")
end, {})

vim.api.nvim_create_user_command("MvnUpdate", function()
    vim.cmd("terminal ./mvnw clean install -U")
end, {})

vim.api.nvim_create_user_command("MvnTest", function()
    vim.cmd("terminal ./mvnw test")
end, {})
