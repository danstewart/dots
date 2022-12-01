local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

lspconfig.pyright.setup {
    settings = {python = {analysis = {diagnosticMode = "openFilesOnly"}}},
    on_attach = on_attach,
    capabilities = capabilities
}
