local cmd = { 'node', vim.fn.expand("$HOME/projects/oss/nunjucks-lsp/server/out/server.js"), '--', '--stdio' }

local config = vim.lsp.config("nunjucks-lsp", {
  name = "nunjucks-lsp",
  cmd = cmd,
  on_attach = function (args)
  end,
  filetypes = { "nunjucks" },
  root_markers = { "package.json", ".git" },
  -- Settings should be nested under the LSP section name
  settings = {
    ["nunjucks-lsp"] = {
      maxNumberOfProblems = 1000,
      templatePaths = {"./templates", "./views"},
      enabledFeatures = {
        completion = true,
        diagnostics = true,
        hover = true
      }
    }
  },
  -- Add initialization options as backup
  init_options = {
    maxNumberOfProblems = 1000,
    templatePaths = {"./templates", "./views"},
    enabledFeatures = {
      completion = true,
      diagnostics = true,
      hover = true
    }
  }
})

local client = vim.lsp.start_client(vim.lsp.config["nunjucks-lsp"])

-- Auto-attach to .njk files
vim.api.nvim_create_autocmd("BufRead", {
  pattern = {"*.njk", "*.nunjucks", "*.html"},
  callback = function()
    if not client then
      vim.notify("Failed to start Nunjucks LSP", vim.log.levels.ERROR)
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    vim.lsp.buf_attach_client(bufnr, client)

    -- Optional: Show a message when attached
    vim.notify("Nunjucks LSP attached", vim.log.levels.INFO)
  end
})

-- Optional: Add filetype detection for .njk files
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.njk", "*.nunjucks"},
  callback = function()
    vim.bo.filetype = "html.nunjucks"
  end
})

