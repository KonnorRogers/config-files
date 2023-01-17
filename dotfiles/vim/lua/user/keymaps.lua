-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Jump based on folds
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Movement
-- Using splits
keymap("n", "<Leader>sp", ":split<space>", opts)
keymap("n", "<Leader>vs", ":vsplit<space>", opts)

-- Buffer switching
keymap("n", "<Leader><Leader>", "<C-^>", opts)
keymap("n", "[b", ":bprev<CR>", opts)
keymap("n", "]b", ":bnext<CR>", opts)
keymap("n", "<C-b>", ":bdelete<CR>", opts)

-- Tab switching
keymap("n", "<Leader>tn", ":tabnew<CR>", opts)
keymap("n", "<Leader>tj", ":tabnext<CR>", opts)
keymap("n", "<Leader>tk", ":tabprev<CR>", opts)
keymap("n", "<Leader>tc", ":tabclose<CR>", opts)

-- editing vim config
keymap("n", "<Leader>rc", ":edit $HOME/.vim/vimrc<CR>", opts)
keymap("n", "<Leader>dv", ":edit $HOME/.vim<CR>", opts)
keymap("n", "<Leader>rv", ":source $HOME/.config/nvim/init.vim<CR>", opts)

-- saving made eaiser
keymap("n", "<Leader>ww", ":w!<CR>", opts)
keymap("n", "<Leader>wq", ":wq!<CR>", opts)

-- quit
keymap("n", "<Leader>qq", ":q!<CR>", opts)

-- Quickfix Navigation
keymap("n", "]q", ":cnext<CR>zz", opts)
keymap("n", "[q", ":cprevious<CR>zz", opts)
keymap("n", "[Q", ":cfirst<CR>zz", opts)
keymap("n", "]Q", ":clast<CR>zz", opts)

-- Custom commands
keymap("n", "<Leader>kp", ":!kubs pull && kubs git_push", opts)
keymap("n", "<Leader>kc", ":!kubs git_pull && kubs copy<cr>", opts)

-- Vim based file navigation
keymap("n", "<Leader>vf", ":find ./**/*", opts)
keymap("n", "<Leader>vF", ":find ", opts)
keymap("n", "<Leader>e", ":edit ./", opts)
keymap("n", "<Leader>E", ":edit<space>", opts)
-- bind <Leader>gw to grep word under cursor
keymap("n", "<Leader>gw", ':grep! "\b<C-R><C-W>\b"<CR>:cw<CR>', opts)

keymap("n", "<Leader>rf", ":call myfunctions#RenameFile()<cr>", opts)

-- Create a new file
keymap("n", "<Leader>to", ":edit <C-R>=expand('%:p:h') . '/'<CR>", opts)
keymap("n", "<Leader>td", ":!mkdir -p <C-R>=expand('%:p:h') . '/'<CR>", opts)

-- Run ctags on current directory
keymap("n", "<Leader>gt", ":call myfunctions#GitCtags()<CR>", opts)

-- RainbowParentheses
keymap("n", "<Leader>rp", ":RainbowParentheses!!<CR>", opts)

-- Ragtag
keymap("i", "<M-o>", "<Esc>o", opts)
keymap("i", "<C-j>", "<Down>", opts)

keymap("i", "<C-n>", ":Explore<CR>", opts)
keymap("n", "<C-n>", ":Explore<CR>", opts)
keymap("v", "<C-n>", ":Explore<CR>", opts)

keymap("n", "<Leader>cl", ":colorscheme xcodelighthc<CR>", opts)
keymap("n", "<Leader>cd", ":colorscheme xcodedarkhc<CR>", opts)

