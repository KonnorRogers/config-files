pcall(require, "lspconfig")

pcall(require, "user.lsp.mason")
handlers = require("user.lsp.handlers")

if handlers then
  handlers.setup()
end

pcall(require, "user.lsp.null-ls")
