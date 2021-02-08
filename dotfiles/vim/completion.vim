let g:completion_enable_snippet = 'UltiSnips'
let g:completion_confirm_key = "\<C-y>"

:lua << EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_exec([[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        augroup lsp_document_highlight
          autocmd!
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]], false)
    end
  end

--
--  -- Use a loop to conveniently both setup defined servers
--  -- and map buffer local keybindings when the language server attaches
--  local servers = {
--    {name = "gopls"},
--    {name = "solargraph"},
--    {
--      name = "tsserver",
--      config = {
--        -- cmd = {
--        --   "typescript-language-server",
--        --   "--stdio",
--        --   "--tsserver-log-file",
--        --   "tslog"
--        -- }
--        -- See https://github.com/neovim/nvim-lsp/issues/237
--        root_dir = nvim_lsp.util.root_pattern("tsconfig.json", ".git"),
--      }
--    },
--    {name = "vimls"},
--    {name = "dockerls"},
--    {name = "yamlls"},
--    {name = "bashls"},
--    {name = "gopls"}
--  }

--   for _, lsp in ipairs(servers) do
--     if lsp.config then
--       lsp.config.on_attach = on_attach
--     else
--       lsp.config = {
--         on_attach = on_attach
--       }
--     end
--
--     nvim_lsp[lsp.name].setup(lsp.config)
--   end


  local chain_complete_list = {
    default = {
      {complete_items = {'lsp', 'ts', 'snippet'}},
      {complete_items = {'path'}, triggered_only = {'/'}},
      {complete_items = {'buffers'}},
    },
    string = {
      {complete_items = {'path'}, triggered_only = {'/'}},
    },
    comment = {},
  }

  require"completion".on_attach({
      sorting = "alphabet",
      matching_strategy_list =
{"exact", "substring", "fuzzy", "all"}
,
      chain_complete_list = chain_complete_list,
  })
EOF

" Treesitter
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }


autocmd BufEnter * lua require'completion'.on_attach()

augroup CompletionTriggerCharacter
    autocmd!
    autocmd BufEnter * let g:completion_trigger_character = ['.', '::']
augroup end

