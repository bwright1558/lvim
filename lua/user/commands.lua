-- Trim trailing whitespace and newlines at EOF on save.
vim.api.nvim_create_user_command("TrimWhitespace", "%s/\\s\\+$//e", {})
vim.api.nvim_create_user_command("TrimNewlines", "%s/\\($\\n\\s*\\)\\+\\%$//e", {})
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*"},
  callback = function()
    vim.api.nvim_exec("TrimWhitespace", false)
    vim.api.nvim_exec("TrimNewlines", false)
  end,
})

-- Formatting
vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting_seq_sync, {})

-- Change filetype for certain types of files with alternate file extension.
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*/.ebextensions/*.config", "*.yml.j2"},
  callback = function() vim.opt.filetype = "yaml" end,
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.json.j2"},
  callback = function() vim.opt.filetype = "json" end,
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.conf.j2"},
  callback = function() vim.opt.filetype = "conf" end,
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"haproxy.cfg.j2"},
  callback = function() vim.opt.filetype = "haproxy" end,
})
