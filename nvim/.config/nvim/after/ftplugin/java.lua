if vim.fn.executable("java") == 0 then
    return
end

local ok_registry, registry = pcall(require, "mason-registry")
if not ok_registry or not registry.has_package("jdtls") then
    return
end

local ok_package, package = pcall(registry.get_package, "jdtls")
if not ok_package or not package:is_installed() then
    return
end

local install_path = require("mason-core.installer.InstallLocation").global():package(package.name)

local root_dir = require("lspconfig.util").root_pattern(
    ".git",
    "gradlew",
    "mvnw",
    "pom.xml",
    "build.gradle",
    "build.gradle.kts"
)(vim.fn.expand("%:p"))

if not root_dir then
    return
end

local launcher = vim.fn.glob(install_path .. "/plugins/org.eclipse.equinox.launcher_*.jar", true, true)[1]
local config_dir = install_path .. "/config_linux"

if launcher == nil or launcher == "" or vim.fn.isdirectory(config_dir) == 0 then
    return
end

local project_name = vim.fs.basename(root_dir)
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls-workspace/" .. project_name
local lsp = require("config.lsp")
local jdtls = require("jdtls")

jdtls.start_or_attach({
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        launcher,
        "-configuration",
        config_dir,
        "-data",
        workspace_dir,
    },
    root_dir = root_dir,
    capabilities = lsp.capabilities,
    on_attach = lsp.on_attach,
})
