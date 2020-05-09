augroup set_formatting
  autocmd!
  if exists(':RainbowParentheses')
    autocmd FileType * RainbowParentheses
  endif

  "removes auto-commenting when hitting <CR>
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
