-- Keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.insert_mode["jk"] = false
lvim.keys.insert_mode["kj"] = false
lvim.keys.insert_mode["jj"] = false
lvim.keys.normal_mode["<S-l>"] = false
lvim.keys.normal_mode["<S-h>"] = false
lvim.keys.normal_mode["<C-h>"] = "<cmd>lua require('user.win').move('h')<cr>"
lvim.keys.normal_mode["<C-j>"] = "<cmd>lua require('user.win').move('j')<cr>"
lvim.keys.normal_mode["<C-k>"] = "<cmd>lua require('user.win').move('k')<cr>"
lvim.keys.normal_mode["<C-l>"] = "<cmd>lua require('user.win').move('l')<cr>"
lvim.keys.term_mode["<C-k>"] = [[<C-\><C-n>]] -- experimental

-- Special mapping to adjust indentation when moving blocks of code up and down lines.
lvim.keys.visual_block_mode["J"] = ":move '>+1<cr>gv=gv"
lvim.keys.visual_block_mode["K"] = ":move '<-2<cr>gv=gv"
