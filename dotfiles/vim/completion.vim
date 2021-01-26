" let g:completion_enable_snippet = 'UltiSnips'

" set omnifunc=v:lua.vim.lsp.omnifunc
" autocmd BufEnter * lua require'completion'.on_attach()
" :lua << END
"   nvim_lsp = require "lspconfig"
"   nvim_lsp.tsserver.setup{ on_attach=require'completion'.on_attach }
"   nvim_lsp.solargraph.setup{ on_attach=require'completion'.on_attach }
"   nvim_lsp.vimls.setup{ on_attach=require'completion'.on_attach }
"   nvim_lsp.dockerls.setup{ on_attach=require'completion'.on_attach }
"   nvim_lsp.yamlls.setup{ on_attach=require'completion'.on_attach }
"   nvim_lsp.bashls.setup{ on_attach=require'completion'.on_attach }
"   nvim_lsp.elixirls.setup{ on_attach=require'completion'.on_attach }
"   nvim_lsp.gopls.setup {
"       cmd = {"gopls", "serve"},
"       settings = {
"         gopls = {
"           analyses = {
"             unusedparams = true,
"           },
"           staticcheck = true,
"         },
"       },
"     }
" END

" nnoremap <silent> <Leader>vdd                 <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> <Leader>vdf                 <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> <Leader>vh                  <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> <Leader>vi                  <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <Leader>vs                  <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> <Leader>vt                  <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> <Leader>vr                  <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> <Leader>vn                  <cmd>lua vim.lsp.buf.rename()<CR>
" nnoremap <silent> <leader>vca                 <cmd>lua vim.lsp.buf.code_action()<CR>
" nnoremap <silent> <leader>vsd                 <cmd>lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>

" let g:completion_matching_strategy_list = ["exact", "substring", "fuzzy"]
" let g:completion_chain_complete_list = {
"     \ 'default': [
"     \    {'complete_items': ['lsp', 'snippet', 'buffers' ]},
"     \    {'mode': '<c-p>'},
"     \    {'mode': '<c-n>'}
"     \ ]
" \ }

" Treesitter
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>crn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>as  <Plug>(coc-codeaction-selected)
nmap <leader>as  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ca  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>la  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>le  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>lc  :<C-u>CocList commands<cr>
" Find symbol of current document.l
nnoremap <silent><nowait> <leader>lo  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>li  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>p  :<C-u>CocListResume<CR>
"}}}
