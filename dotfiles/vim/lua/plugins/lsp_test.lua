local cmd = { 'node', vim.fn.expand("$HOME/projects/oss/webawesome-lsp/server/out/server.js"), '--', '--stdio' }

local client = vim.lsp.start_client {
  name = "test-lsp",
  cmd = cmd,
  on_attach = function (args)
  end,
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function ()
    -- vim.cmd.echo(cmd)
    if not client then
      vim.cmd.echo("\"Something went wrong\"")
      return
    end

    vim.lsp.buf_attach_client(0, client)
  end
})


