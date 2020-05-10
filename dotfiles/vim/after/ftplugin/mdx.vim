if executable('prettier')
  augroup mdxFormatting
    autocmd!

    autocmd FileType mdx setlocal makeprg=prettier\ --stdin-filepath\ %\ --parser\ mdx\ --write

    autocmd BufWritePost *.mdx silent make! % | edit
  augroup END
end

setlocal foldmethod=indent
