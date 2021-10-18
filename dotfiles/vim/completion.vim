let g:completion_enable_snippet = 'UltiSnips'
let g:completion_confirm_key = "\<C-y>"

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `ultisnips` user.
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      })
    },
    sources = {
      { name = 'nvim_lsp' },
      -- For ultisnips user.
      { name = 'ultisnips' },
      { name = 'buffer' },
    }
  })

  local function config(_config)
      return vim.tbl_deep_extend("force", {
          capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      }, _config or {})
  end
  require'lspconfig'.tsserver.setup(config())
  require'lspconfig'.solargraph.setup(config())
  require'lspconfig'.yamlls.setup(config())

  require'lspconfig'.gopls.setup(config({
      cmd = {"gopls", "serve"},
      settings = {
          gopls = {
              analyses = {
                  unusedparams = true,
              },
              staticcheck = true,
          },
      },
  }))
EOF
