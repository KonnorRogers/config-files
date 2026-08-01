-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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

-- Jump based on folds
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Buffer switching
keymap("n", "<Leader><Leader>", "<C-^>", opts)
keymap("n", "[b", ":bprev<CR>", opts)
keymap("n", "]b", ":bnext<CR>", opts)
keymap("n", "<C-b>", ":bdelete<CR>", opts)

-- editing vim config
keymap("n", "<Leader>rc", ":edit $HOME/.config/lazyvim/init.lua<CR>", opts)
keymap("n", "<Leader>dv", ":edit $HOME/.config/lazyvim<CR>", opts)
keymap("n", "<Leader>rv", ":source $HOME/.config/lazyvim/init.lua<CR>", opts)

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

vim.keymap.set({ "n", "i", "v" }, "<C-n>", function()
  vim.cmd("Explore " .. vim.fn.fnameescape(vim.fn.expand("%:p:h")))
end, { desc = "Explore current file directory" })

keymap("n", "<Leader>cl", ":colorscheme xcodelighthc<CR>", opts)
keymap("n", "<Leader>cd", ":colorscheme xcodedarkhc<CR>", opts)

-- Esc key in terminal mode
keymap("t", "<Esc>", "<C-\\><C-n>")

if vim.fn.executable("ag") == 1 then
  vim.opt.grepprg = "ag --vimgrep"
  vim.opt.grepformat = "%f:%l:%c%m"

  -- populate quickfix with \
  vim.api.nvim_create_user_command("Ag", function(o)
    vim.cmd("silent! grep! " .. o.args)
    vim.cmd.cwindow()
    vim.cmd("redraw!")
  end, { nargs = "+", complete = "file", bar = true })

  vim.keymap.set("n", "\\", ":Ag ")
end
