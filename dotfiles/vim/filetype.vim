augroup filetypedetect
  au! BufRead,BufNewFile *nc setfiletype nc
  autocmd BufNewFile,BufReadPost *.ino,*.pde setfiletype cpp
  autocmd BufNewFile,BufRead *.md,*.markdown setfiletype markdown
  autocmd BufNewFile,BufRead *.mdx,*.md,*.markdown setlocal foldmethod=indent
  autocmd BufNewFile,BufRead Dockerfile* if (&ft != 'dockerfile' && &ft != '') | set filetype+=.dockerfile | else | set filetype=dockerfile | fi
  autocmd BufNewFile,BufRead *.tt if (&ft != 'eruby' && &ft != '') | set filetype+=.eruby | else | set filetype=eruby | fi
  autocmd BufNewFile,BufRead *.liquid set filetype=liquid.html
  autocmd BufNewFile,BufRead */.vim set filetype=netrw
  autocmd BufNewFile,BufRead * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END


