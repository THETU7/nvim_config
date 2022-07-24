local lsp_installer = require("nvim-lsp-installer")

lsp_installer.setup {
  github = {
    -- The template URL to use when downloading assets from GitHub.
    -- The placeholders are the following (in order):
    -- 1. The repository (e.g. "rust-lang/rust-analyzer")
    -- 2. The release version (e.g. "v0.3.0")
    -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
    -- download_url_template = "https://github.com/%s/releases/download/%s/%s"
    download_url_template = "https://hub.fastgit.org/%s/releases/download/%s/%s"
  }
}
local lspconfig = require("lspconfig")

local servers = {
  sumneko_lua = require("lspconf.lua"),
  jsonls = require("lspconf.jsonls"),
  pyright = require("lspconf.pyright"),
  -- bzl = require("lspconf.bzl")
  xmake = require("lspconf.xmake")
}

-- 自动安装 LanguageServers
--for name, _ in pairs(servers) do
--local server_is_found, server = lsp_installer.get_server(name)
--if server_is_found then
--if not server:is_installed() then
--print("Installing " .. name)
--server:install()
--end
--end
--end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

for key, value in pairs(servers) do
  local opts = {capabilities = capabilities}
  opts = vim.tbl_deep_extend("force", value, opts)
  lspconfig[key].setup(opts)
end

lspconfig.clangd.setup {
  capabilities = capabilities
}

lspconfig.bzl.setup {
  capabilities = capabilities
}
