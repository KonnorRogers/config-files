let g:completion_enable_snippet = 'UltiSnips'

autocmd BufEnter * lua require'completion'.on_attach()
set omnifunc=v:lua.vim.lsp.omnifunc

imap <silent> <c-p> <Plug>(completion_trigger)
let g:completion_matching_strategy_list = ["exact", "substring", "fuzzy"]
let g:completion_chain_complete_list = {
    \ 'default': [
    \    {'complete_items': ['lsp', 'snippet', 'buffers', 'tags', 'path' ]},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \ ]
\ }

autocmd BufEnter * lua require'completion'.on_attach()
:lua << END
  nvim_lsp = require "lspconfig"
  nvim_lsp.tsserver.setup{ on_attach=require'completion'.on_attach }
  nvim_lsp.solargraph.setup{ on_attach=require'completion'.on_attach }
  nvim_lsp.vimls.setup{ on_attach=require'completion'.on_attach }
  nvim_lsp.dockerls.setup{ on_attach=require'completion'.on_attach }
  nvim_lsp.yamlls.setup{ on_attach=require'completion'.on_attach }
  nvim_lsp.bashls.setup{ on_attach=require'completion'.on_attach }
  nvim_lsp.elixirls.setup{ on_attach=require'completion'.on_attach }
  nvim_lsp.gopls.setup {
      cmd = {"gopls", "serve"},
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    }
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


lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
