local opts = {
  default_config = {
    cmd = {'emmet-language-server', '--stdio'};
    filetypes = {
        'html', 'typescriptreact', 'javascriptreact', 'javascript',
        'typescript', 'javascript.jsx', 'typescript.tsx', 'css'
    },
    root_dir = util.root_pattern("package.json", ".git"),
    settings = {}
  };
}

return opts
