-- General
lvim.log.level = "warn"
lvim.colorscheme = "nightfox"

-- This feature doesn't seem to work as expected. It appears to delete code
-- that shouldn't be deleted (like function argument names) under certain conditions.
lvim.format_on_save = false

vim.opt.cmdheight = 1
vim.opt.showtabline = 0
-- vim.opt.timeoutlen = 500
vim.opt.modeline = false
vim.opt.relativenumber = true
vim.opt.whichwrap:remove({ "<", ">", "[", "]", "h", "l" })
