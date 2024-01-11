pcall(require, "lspconfig")

pcall(require, "user.lsp.mason")
handlers = require("user.lsp.handlers")

vim.g["ruby_host_prog"] = "$HOME/.asdf/shims/neovim-ruby-host"

if handlers then
  handlers.setup()
end

pcall(require, "user.lsp.null-ls")
