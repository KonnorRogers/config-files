-- local cmd = { 'node', vim.fn.expand("$HOME/projects/oss/webawesome-lsp/server/out/server.js"), '--', '--stdio' }

-- local client = vim.lsp.start_client {
--   name = "test-lsp",
--   cmd = cmd,
--   on_attach = function (args)
--   end,
-- }

-- vim.api.nvim_create_autocmd("BufRead", {
--   pattern = "*.html,*.css,*.svelte,*.vue,*.jsx,*.tsx,*.ts,*.js,*.astro",
--   -- pattern = "*",
--   callback = function ()
--     if not client then
--       vim.notify_once("\"Something went wrong attaching LSP TEST\"")
--       return
--     end

--     vim.lsp.buf_attach_client(0, client)
--   end
-- })


