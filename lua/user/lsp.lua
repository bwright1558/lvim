-- LSP
lvim.lsp.diagnostics.virtual_text = false
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "yamlls" })
-- lvim.lsp.automatic_servers_installation = false

lvim.lsp.on_attach_callback = function(client, bufnr)
  require("lsp_signature").on_attach()
end
