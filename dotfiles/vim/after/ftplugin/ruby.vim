if executable("rubocop")
  augroup RubyFormatting
    autocmd!
    autocmd BufWritePre *.rb execute ":RuboCop -a"
  augroup END
endif
