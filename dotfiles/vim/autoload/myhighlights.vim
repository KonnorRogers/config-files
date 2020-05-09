function! myhighlights#KolorHighlights() abort
  highlight Normal ctermbg=0
  highlight Folded ctermbg=08 ctermfg=12
  highlight FoldColumn ctermbg=0
  " highlight WhiteSpace ctermbg=0

  " Gutter
  highlight CursorLineNR ctermbg=0
  highlight LineNR ctermbg=08
  highlight SignColumn ctermbg=0
  highlight CursorLine ctermbg=08

  " Columns
  highlight VertSplit ctermbg=08
  highlight ColorColumn ctermbg=08
  highlight CursorColumn ctermbg=08

  "Blank buffer
  highlight EndOfBuffer ctermbg=0

  " Parens
  highlight MatchParen ctermbg=8 ctermfg=13 cterm=NONE guibg=#1c1c1c guifg=#FF5FD7 gui=NONE
  highlight StatusLine guibg=#87875f guifg=#262626 ctermbg=101 ctermfg=0 cterm=NONE gui=NONE
  highlight StatusLineNC guibg=#87875f guifg=#262626 ctermbg=101 ctermfg=0 cterm=inverse gui=inverse
endfunction

function! myhighlights#MedicChalkHighlights() abort
  highlight Folded ctermbg=0 ctermfg=5 guibg=#000000 guifg=#CD00CD
endfunction
