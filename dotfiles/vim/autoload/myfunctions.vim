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

function! myfunctions#InstallLanguageServers()
  let s:npm_install = 'npm install -g '

  " key = executable, value = install
  let s:npm_lang_servers = {
        \ 'docker-langserver': 'dockerfile-language-server-nodejs',
        \ 'bash-language-server': 'bash-language-server',
        \ 'yaml-language-server': 'yaml-language-server',
        \ 'typescript-language-server': 'typescript-language-server',
        \ 'vim-language-server': 'vim-language-server',
        \ }

  let s:npm_servers_to_install = ''

  for key in keys(s:npm_lang_servers)
    if !executable(key)
      let s:npm_servers_to_install = s:npm_servers_to_install . s:npm_lang_servers[key] . ' '
    endif
  endfor

  if !empty(s:npm_servers_to_install)
    execute "!npm install -g " . s:npm_servers_to_install
    execute "!asdf reshim"
  endif

  if !executable('solargraph')
    execute "!gem install solargraph"
  endif
endfunction
