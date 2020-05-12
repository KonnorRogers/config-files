if executable('rubocop')
  setlocal makeprg=rubocop\ -a\ --format\ emacs\ %

  augroup rubyFormatting
    autocmd!
    autocmd BufWritePost *.rb silent make! % | edit
  augroup END
endif
