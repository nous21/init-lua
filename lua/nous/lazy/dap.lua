local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

dap.adapters.go = {
    type = "server",
    port = "${port}",
    executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:${port}" },
    },
}

dap.configurations.go = {
    {
        type = "go",
        name = "Debug file",
        request = "launch",
        program = "${workspaceFolder}",
        env = {
            CGO_ENABLED = "1",
            CGO_CFLAGS = "-U_FORTIFY_SOURCE",
        },
    },
}

dap.adapters.java = function(callback)
vim.lsp.buf_request(
    0,
    "workspace/executeCommand",
    {
        command = "vscode.java.startDebugSession",
        arguments = {},
    },
    function(err, port)
    if err then
        vim.notify("Erro ao iniciar debug session: " .. err.message, vim.log.levels.ERROR)
        return
        end
        callback({
            type = "server",
            host = "127.0.0.1",
            port = port,
        })
        end
)
end

dap.configurations.java = {
    {
        type = "java",
        name = "Debug",
        request = "launch",
        mainClass = function()
            return vim.fn.input("Main class: ")
        end,
    },
    {
        type = "java",
        name = "Debug (attach)",
        request = "attach",
        hostName = "127.0.0.1",
        port = function()
            return tonumber(vim.fn.input("Port: ")) or 5005
        end,
    },
}

vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dr", dap.repl.open)
vim.keymap.set("n", "<leader>dq", dap.terminate)
vim.keymap.set("n", "<leader>du", dapui.close)
