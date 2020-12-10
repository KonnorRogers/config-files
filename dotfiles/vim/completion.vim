let g:completion_enable_snippet = 'UltiSnips'

set omnifunc=v:lua.vim.lsp.omnifunc
autocmd BufEnter * lua require'completion'.on_attach()
:lua << END
  require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
  require'lspconfig'.solargraph.setup{ on_attach=require'completion'.on_attach }
  require'lspconfig'.vimls.setup{ on_attach=require'completion'.on_attach }
  require'lspconfig'.dockerls.setup{ on_attach=require'completion'.on_attach }
  require'lspconfig'.yamlls.setup{ on_attach=require'completion'.on_attach }
  require'lspconfig'.bashls.setup{ on_attach=require'completion'.on_attach }
  require'lspconfig'.elixirls.setup{ on_attach=require'completion'.on_attach }
END

nnoremap <silent> <Leader>vdd                 <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <Leader>vdf                 <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>vh                  <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>vi                  <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <Leader>vs                  <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <Leader>vt                  <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <Leader>vr                  <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <Leader>vn                  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>vca                 <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>vsd                 <cmd>lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>

let g:completion_matching_strategy_list = ["exact", "substring", "fuzzy"]
let g:completion_chain_complete_list = {
    \ 'default': [
    \    {'complete_items': ['lsp', 'snippet', 'buffers' ]},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \ ]
\ }

" Treesitter
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
