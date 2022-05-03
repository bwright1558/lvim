-- Additional Plugins
lvim.plugins = {
  { "EdenEast/nightfox.nvim" },
  { "ggandor/lightspeed.nvim" },
  { "sindrets/diffview.nvim" },
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
      -- vim.g.indent_blankline_show_first_indent_level = false
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "alpha" }
      vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile", "nowrite" }
    end,
  },
  -- -- fatih/vim-go does not yet support generics in go 1.18.
  -- {
  --   "fatih/vim-go",
  --   ft = "go",
  --   setup = function()
  --     vim.g.go_def_mapping_enabled = false
  --   end,
  -- },
  {
    "ray-x/go.nvim",
    ft = "go",
    setup = function()
      require("go").setup()
    end,
  },
  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python",
  },
}
