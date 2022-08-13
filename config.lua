-- general
lvim.log.level = "warn"
lvim.format_on_save.pattern = { "*.json", "*.lua" }
lvim.colorscheme = "nightfox"

vim.opt.cmdheight = 1
vim.opt.showtabline = 0
vim.opt.modeline = false
vim.opt.relativenumber = true
vim.opt.whichwrap:remove({ "<", ">", "[", "]", "h", "l" })

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.insert_mode["jk"] = false
lvim.keys.insert_mode["kj"] = false
lvim.keys.insert_mode["jj"] = false
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = false
lvim.keys.normal_mode["<S-h>"] = false
lvim.keys.normal_mode["<C-h>"] = "<cmd>FocusSplitLeft<cr>"
lvim.keys.normal_mode["<C-j>"] = "<cmd>FocusSplitDown<cr>"
lvim.keys.normal_mode["<C-k>"] = "<cmd>FocusSplitUp<cr>"
lvim.keys.normal_mode["<C-l>"] = "<cmd>FocusSplitRight<cr>"
lvim.keys.term_mode["<C-k>"] = [[<C-\><C-n>]] -- experimental

-- Special mapping to adjust indentation when moving blocks of code up and down lines.
lvim.keys.visual_block_mode["J"] = ":move '>+1<cr>gv=gv"
lvim.keys.visual_block_mode["K"] = ":move '<-2<cr>gv=gv"

-- Which Key mappings
lvim.builtin.which_key.mappings[";"] = { "<cmd>Telescope filetypes<cr>", "Filetypes" }
lvim.builtin.which_key.mappings["G"] = { ":G ", "Git Command", silent = false }
lvim.builtin.which_key.mappings["g"]["g"] = { "<cmd>G <bar> only<cr>", "Summary" }
lvim.builtin.which_key.mappings["g"]["d"] = { "<cmd>DiffviewOpen<cr>", "Git Diff" }
lvim.builtin.which_key.mappings["g"]["h"] = { "<cmd>DiffviewFileHistory<cr>", "File History" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<cr>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  t = { "<cmd>TroubleToggle<cr>", "Info" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
  f = { "<cmd>TroubleToggle lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "QuickFix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "LocationList" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

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

-- User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = false
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.bufferline.active = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.project.manual_mode = true

-- Lualine
lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.options.component_separators = { left = "", right = "" }
lvim.builtin.lualine.options.section_separators = { left = "", right = "" }
lvim.builtin.lualine.options.disabled_filetypes = { "alpha", "NvimTree", "Outline" }

-- Treesitter
lvim.builtin.treesitter.ensure_installed = "all"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.indent.enable = false

-- LSP
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "yamlls" })
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.on_attach_callback = function(client, bufnr)
  require("lsp_signature").on_attach()
end

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- Trim trailing whitespace and newlines at EOF on save.
vim.api.nvim_create_user_command("TrimWhitespace", "%s/\\s\\+$//e", {})
vim.api.nvim_create_user_command("TrimNewlines", "%s/\\($\\n\\s*\\)\\+\\%$//e", {})

-- Formatting
vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting_seq_sync, {})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function()
    vim.api.nvim_exec("TrimWhitespace", false)
    vim.api.nvim_exec("TrimNewlines", false)
  end,
})

-- Change filetype for certain types of files with alternate file extension.
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*/.ebextensions/*.config", "*.yml.j2" },
  callback = function() vim.opt.filetype = "yaml" end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.json.j2" },
  callback = function() vim.opt.filetype = "json" end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.conf.j2" },
  callback = function() vim.opt.filetype = "conf" end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "haproxy.cfg.j2" },
  callback = function() vim.opt.filetype = "haproxy" end,
})

-- Run gofmt + goimport on save.
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.go" },
  callback = function()
    require("go.format").goimport()
    vim.lsp.buf.formatting_seq_sync({})
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.md" },
  callback = function()
    vim.opt_local.wrap = false
  end,
})

-- Additional Plugins
lvim.plugins = {
  { "EdenEast/nightfox.nvim" },
  { "sindrets/diffview.nvim" },
  { "ggandor/lightspeed.nvim" },
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
    ft = "fugitive",
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup()
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
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "alpha" }
      vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile", "nowrite" }
    end,
  },
  {
    "ray-x/go.nvim",
    ft = "go",
    config = function()
      require("go").setup()
    end,
  },
  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python",
  },
  {
    "beauwilliams/focus.nvim",
    config = function()
      require("focus").setup({
        relativenumber = true,
      })
    end,
  },
}
