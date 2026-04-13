local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
    M.capabilities = cmp_lsp.default_capabilities(M.capabilities)
end

function M.on_attach(_, bufnr)
    local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("n", "gd", vim.lsp.buf.definition, "LSP definition")
    map("n", "gD", vim.lsp.buf.declaration, "LSP declaration")
    map("n", "gr", vim.lsp.buf.references, "LSP references")
    map("n", "gi", vim.lsp.buf.implementation, "LSP implementation")
    map("n", "K", vim.lsp.buf.hover, "LSP hover")
    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("n", "<leader>e", vim.diagnostic.open_float, "Line diagnostics")
    map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
    map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
    map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostics list")
end

function M.setup()
    local lspconfig = require("lspconfig")

    vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded" },
        underline = true,
        virtual_text = {
            spacing = 2,
            source = "if_many",
        },
    })

    local servers = {
        bashls = {},
        jsonls = {},
        lua_ls = {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        checkThirdParty = false,
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        },
        yamlls = {},
    }

    for server, config in pairs(servers) do
        config.capabilities = M.capabilities
        config.on_attach = M.on_attach
        lspconfig[server].setup(config)
    end
end

return M
