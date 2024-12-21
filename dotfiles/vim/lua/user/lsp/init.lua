-- This needs to come first.
local handlers_status, handlers = pcall(require, "user.lsp.handlers")

if handlers_status then
  handlers.setup()
end

pcall(require, "lspconfig")
pcall(require, "user.lsp.mason")

vim.g["ruby_host_prog"] = "$HOME/.asdf/shims/neovim-ruby-host"

pcall(require, "user.lsp.null-ls")
