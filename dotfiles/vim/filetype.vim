"augroup filetypedetect
"  au! BufRead,BufNewFile *nc setfiletype nc "http://www.vim.org/scripts/script.php?script_id=1847
"  "html.ep now handled by https://github.com/yko/mojo.vim
"  autocmd BufNewFile,BufReadPost *.ino,*.pde setfiletype cpp

"  " Set markdown files to markdown filetype
"  autocmd BufNewFile,BufRead *.md,*.markdown setfiletype=markdown
"  autocmd BufNewFile,BufRead *.mdx,*.md,*.markdown setlocal foldmethod=indent
"  autocmd BufNewFile,BufRead Dockerfile* set filetype=dockerfile
"augroup END

""removes auto-commenting when hitting <CR>
"setlocal formatoptions-=c formatoptions-=r formatoptions-=o

