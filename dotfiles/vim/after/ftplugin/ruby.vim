if executable('rubocop')
  " setlocal makeprg=$GEM_PATH/bin/rubocop\ -a\ --format\ emacs\ %
  function! s:Format() abort
    let l:filename = %
    let l:rubocop = 'rubocop -a --format emacs' . l:filename
  endfunction

  augroup rubyFormatting
    autocmd!
    autocmd BufWritePost *.rb silent exec "rubocop -a --format emacs %" | edit
  augroup END
endif
