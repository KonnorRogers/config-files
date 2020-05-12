if executable("rubocop")
  augroup rubyFormatting
    autocmd!
    autocmd BufWritePost *.rb RuboCop
  augroup END
endif
