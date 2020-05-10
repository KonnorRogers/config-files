setlocal textwidth=72

" if executable('prettier')
"   setlocal makeprg=prettier\ --parser\ markdown\ --write\ %

"   augroup mdFormatting
"     autocmd!
"     autocmd BufWritePre *.md,*.markdown silent make! % | edit
"   augroup END
" endif

