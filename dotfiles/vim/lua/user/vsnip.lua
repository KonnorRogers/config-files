vim.cmd([[
" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_snippet_dir = expand('~/.vim/snippets')
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.typescript = ["javascript", "typescriptreact", "javascriptreact"]
let g:vsnip_filetypes.javascriptreact = ["javascript"]
let g:vsnip_filetypes.typescriptreact = ["typescript", "typescriptreact", "javascriptreact"]

" NOTE: You can use other key to expand snippet.

" jump

imap <expr> <C-k>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-k>'
smap <expr> <C-k>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-k>'
imap <expr> <C-j> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-j>'
smap <expr> <C-j> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-j>'

imap <expr> <C-m>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-m>'
smap <expr> <C-m>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-m>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)
]])

