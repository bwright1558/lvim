-- Trim trailing whitespace and newlines at EOF on save.
vim.cmd([[command! Format exe 'lua vim.lsp.buf.formatting()']])
vim.cmd([[command! -nargs=0 TrimWhitespace :%s/\s\+$//e]])
vim.cmd([[command! -nargs=0 TrimNewlines :%s/\($\n\s*\)\+\%$//e]])
vim.cmd([[autocmd BufWritePre * exe 'TrimWhitespace' | exe 'TrimNewlines']])

-- Formatting
vim.cmd([[command! Format exe 'lua vim.lsp.buf.formatting()']])

-- Change filetype for certain types of files with alternate file extension.
vim.cmd([[autocmd BufRead,BufNewFile */.ebextensions/*.config,*.yml.j2 set ft=yaml]])
vim.cmd([[autocmd BufRead,BufNewFile *.json.j2 set ft=json]])
vim.cmd([[autocmd BufRead,BufNewFile *.conf.j2 set ft=conf]])
vim.cmd([[autocmd BufRead,BufNewFile haproxy.cfg.j2 set ft=haproxy]])
