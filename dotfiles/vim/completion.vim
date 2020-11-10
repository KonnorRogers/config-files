let g:completion_enable_snippet = 'UltiSnips'

set omnifunc=v:lua.vim.lsp.omnifunc
autocmd BufEnter * lua require'completion'.on_attach()
:lua << END
  require'nvim_lsp'.tsserver.setup{}
  require'nvim_lsp'.solargraph.setup{}
  require'nvim_lsp'.vimls.setup{}
  require'nvim_lsp'.dockerls.setup{}
  require'nvim_lsp'.yamlls.setup{}
  require'nvim_lsp'.bashls.setup{}
  require'nvim_lsp'.elixirls.setup{}
END

nnoremap <silent> gd            <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gf            <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K             <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD            <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k>         <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD           <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr            <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>lrn    <cmd>lua vim.lsp.buf.rename()<CR>

let g:completion_matching_strategy_list = ["exact", "substring", "fuzzy"]
let g:completion_chain_complete_list = {
    \ 'default': [
    \    {'complete_items': ['lsp', 'snippet', 'buffers' ]},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \ ]
\ }
