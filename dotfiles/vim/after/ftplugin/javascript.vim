if executable('prettier')

  setlocal makeprg=prettier\ --write\ %

  augroup jsFormatting
    autocmd!
    autocmd BufWritePre *.js,*.jsx silent make! % | edit
  augroup END
endif
