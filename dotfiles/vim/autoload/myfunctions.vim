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
        \ 'typescript-language-server': 'typescript-language-server typescript',
        \ 'vim-language-server': 'vim-language-server',
        \ 'diagnostic-languageserver': 'diagnostic-languageserver'
        \ }

  let s:npm_servers_to_install = ''

  for key in keys(s:npm_lang_servers)
    let s:npm_servers_to_install = s:npm_servers_to_install . s:npm_lang_servers[key] . ' '
  endfor

  execute "!yarn global add " . s:npm_servers_to_install
  execute "!gem install solargraph"
  execute "!asdf reshim"

endfunction


function! myfunctions#TreesitterInstall()
  let s:treesitter_completion = [
    \ "ruby",
    \ "typescript",
    \ "javascript",
    \ "go",
    \ "lua",
    \ ]

  for option in s:treesitter_completion
    execute "TSInstall " . option
  endfor
endfunction

