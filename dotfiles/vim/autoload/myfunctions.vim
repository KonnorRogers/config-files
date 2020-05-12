" Custom functions
function! myfunctions#RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    exec ':e ' . new_name
    exec ':bwipeout ' . old_name
    redraw!
  endif
endfunction

" Run ctags
function! myfunctions#GitCtags()
  let s:git_root = systemlist('git rev-parse --show-toplevel')[0]
  let s:tag_dir = '/.git/tags'

  execute "!ctags -R --tag-relative -f " . s:git_root . s:tag_dir
endfunction

function! myfunctions#Rubocop()
  let l:filename = %
  let l:rubocop_cmd = 'rubocop -a --format emacs ' . l:filename
  let l:rubocop_output = system(l:rubocop_cmd)
  edit
endfunction

command! -nargs=0 RuboCop :call myfunctions#Rubocop()
