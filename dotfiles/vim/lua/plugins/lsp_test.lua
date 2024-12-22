-- local client = vim.lsp.start_client {
--   name = "test-lsp",
--   cmd = { vim.fn.expand("$HOME/projects/lsp-from-scratch/exports/server.js") },
--   -- on_attach = function (args)
--   -- end,
-- }

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function ()
--     if not client then
--       vim.cmd.echo("\"Something went wrong\"")
--       return
--     end

--     vim.lsp.buf_attach_client(0, client)
--   end
-- })


