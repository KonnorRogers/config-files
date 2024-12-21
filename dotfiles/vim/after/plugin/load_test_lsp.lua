local client = vim.lsp.start_client {
  name = "test-lsp",
  cmd = { "~/projects/lsp-from-scratch/exports/server.js" },
  on_attach = require("tj.lsp").on_attach
}

if not client then
  vim.notify "Hey, something went wrong"
end

vim.api
