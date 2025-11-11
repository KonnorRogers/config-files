-- -- If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
vim.g.vsnip_snippet_dir = vim.fn.expand('~/.vim/snippets')

local keymap = vim.keymap

keymap.set({"i", "s"}, "<expr> <C-k>", "vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-k>'")
keymap.set({"i", "s"}, "<expr> <C-j>", "vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-j>'")
keymap.set({"i", "s"}, "<expr> <C-y>",   "vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-y>'")

-- Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
-- See https://github.com/hrsh7th/vim-vsnip/pull/50
keymap.set({"n", "x"}, "s", "<Plug>(vsnip-select-text)")
keymap.set({"n", "x"}, "S", "<Plug>(vsnip-cut-text)")

vim.cmd([[
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ["javascript"]
let g:vsnip_filetypes.typescript = ["javascript"]
let g:vsnip_filetypes.typescriptreact = ["typescript", "javascript"]
]])
