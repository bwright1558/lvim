-- General
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "nightfox"
vim.opt.cmdheight = 1
vim.opt.showtabline = 0
vim.opt.timeoutlen = 500
vim.opt.modeline = false
vim.opt.relativenumber = true

-- Keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.insert_mode["jk"] = false
lvim.keys.insert_mode["kj"] = false
lvim.keys.insert_mode["jj"] = false
lvim.keys.normal_mode["<C-h>"] = "<cmd>lua require('utils').win_move('h')<cr>"
lvim.keys.normal_mode["<C-j>"] = "<cmd>lua require('utils').win_move('j')<cr>"
lvim.keys.normal_mode["<C-k>"] = "<cmd>lua require('utils').win_move('k')<cr>"
lvim.keys.normal_mode["<C-l>"] = "<cmd>lua require('utils').win_move('l')<cr>"
lvim.keys.term_mode["<C-k>"] = [[<C-\><C-n>]] -- experimental

-- Special mapping to adjust indentation when moving blocks of code up and down lines.
-- This is buggy without treesitter indent enabled. But at the same time, python
-- indents are a bit wonky when treesitter indent is enabled.
-- lvim.keys.visual_block_mode["J"] = ":move '>+1<cr>gv=gv"
-- lvim.keys.visual_block_mode["K"] = ":move '<-2<cr>gv=gv"

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


-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Which Key Mappings
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<cr>", "Projects" }

-- User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.bufferline.active = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1

-- Lualine
lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.options.component_separators = { left = "", right = "" }
lvim.builtin.lualine.options.section_separators = { left = "", right = "" }
lvim.builtin.lualine.options.disabled_filetypes = { "dashboard", "NvimTree", "Outline" }

-- Treesitter
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.indent.enable = false

-- LSP
lvim.lsp.diagnostics.virtual_text = false
-- lvim.lsp.automatic_servers_installation = false

-- Additional Plugins
lvim.plugins = {
  {"EdenEast/nightfox.nvim"},
  {"tpope/vim-fugitive"},
  {"ggandor/lightspeed.nvim"},
  {
    "fatih/vim-go",
    setup = function()
      vim.g.go_def_mapping_enabled = false
    end,
  },
}
