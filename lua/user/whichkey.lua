-- Which Key Mappings
lvim.builtin.which_key.mappings[";"] = { "<cmd>Telescope filetypes<cr>", "Filetypes" }
lvim.builtin.which_key.mappings["G"] = { ":G ", "Git Command", silent = false }
lvim.builtin.which_key.mappings["g"]["g"] = { "<cmd>G <bar> only<cr>", "Summary" }
lvim.builtin.which_key.mappings["g"]["d"] = { "<cmd>DiffviewOpen<cr>", "Git Diff" }
lvim.builtin.which_key.mappings["g"]["h"] = { "<cmd>DiffviewFileHistory<cr>", "File History" }
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
