-- General
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "nightfox"
vim.opt.cmdheight = 1
vim.opt.showtabline = 0
-- vim.opt.timeoutlen = 500
vim.opt.modeline = false
vim.opt.relativenumber = true
vim.opt.whichwrap:remove({ "<", ">", "[", "]", "h", "l" })

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
lvim.builtin.which_key.mappings["G"] = { "<cmd>Git<cr>", "Git Summary" }

-- Special mapping to adjust indentation when moving blocks of code up and down lines.
lvim.keys.visual_block_mode["J"] = ":move '>+1<cr>gv=gv"
lvim.keys.visual_block_mode["K"] = ":move '<-2<cr>gv=gv"

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
lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>TroubleToggle<cr>", "Trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "Loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
}

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
vim.list_extend(lvim.lsp.override, { "yamlls" })
-- lvim.lsp.automatic_servers_installation = false

-- Additional Plugins
lvim.plugins = {
  {"EdenEast/nightfox.nvim"},
  {"tpope/vim-fugitive"},
  {"ggandor/lightspeed.nvim"},
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").on_attach()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      -- vim.g.indent_blankline_show_first_indent_level = false
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
      vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile", "nowrite" }
    end,
  },
  {
    "fatih/vim-go",
    ft = "go",
    setup = function()
      vim.g.go_def_mapping_enabled = false
    end,
  },
  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python",
  },
}
