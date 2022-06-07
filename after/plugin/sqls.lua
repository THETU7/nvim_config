require "lspconfig".sqls.setup {
  cmd = {"/home/thetu/go/bin/sqls", "-config", "/home/thetu/.config/sqls/config.yml"},
  on_attach = function(client, bufnr)
    require("sqls").on_attach(client, bufnr)
  end
}
