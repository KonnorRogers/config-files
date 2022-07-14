require('snippy').setup({
  scopes = {
    eruby = { '_', 'ruby', 'rails', 'html' },
    haml = { '_', 'ruby', 'rails', 'html' },
    ruby = { '_', 'rails' },
    rails = { '_', 'ruby' },
    typescript = { '_', 'javascript' },
    javascriptreact = { '_', 'javascript' },
    typescriptreact = { '_', 'javascriptreact', 'javascript', 'typescript' },
  },

  mappings = {
    is = {
        ['<c-k>'] = 'expand_or_advance',
        ['<c-j>'] = 'previous',
    },
    nx = {
        ['<c-k>'] = 'cut_text',
    },
  },
})

