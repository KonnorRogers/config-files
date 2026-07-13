-- local cmd = { 'node', vim.fn.expand("$HOME/projects/oss/nunjucks-lsp/server/out/server.js"), '--', '--stdio' }

-- local config = vim.lsp.config("nunjucks-lsp", {
--   name = "nunjucks-lsp",
--   cmd = cmd,
--   on_attach = function (args)
--   end,
--   filetypes = { "nunjucks" },
--   root_markers = { "package.json", ".git" },
--   -- Settings should be nested under the LSP section name
--   settings = {
--     ["nunjucks-lsp"] = {
--       maxNumberOfProblems = 1000,
--       templatePaths = {"./templates", "./views"},
--       enabledFeatures = {
--         completion = true,
--         diagnostics = true,
--         hover = true
--       }
--     }
--   },
--   -- Add initialization options as backup
--   init_options = {
--     maxNumberOfProblems = 1000,
--     templatePaths = {"./templates", "./views"},
--     enabledFeatures = {
--       completion = true,
--       diagnostics = true,
--       hover = true
--     }
--   }
-- })

-- local client = vim.lsp.start_client(vim.lsp.config["nunjucks-lsp"])

-- -- Auto-attach to .njk files
-- vim.api.nvim_create_autocmd("BufRead", {
--   pattern = {"*.njk", "*.nunjucks", "*.html"},
--   callback = function()
--     if not client then
--       vim.notify("Failed to start Nunjucks LSP", vim.log.levels.ERROR)
--       return
--     end

--     local bufnr = vim.api.nvim_get_current_buf()
--     vim.lsp.buf_attach_client(bufnr, client)

--     -- Optional: Show a message when attached
--     vim.notify("Nunjucks LSP attached", vim.log.levels.INFO)
--   end
-- })

-- -- Optional: Add filetype detection for .njk files
-- vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
--   pattern = {"*.njk", "*.nunjucks"},
--   callback = function()
--     vim.bo.filetype = "html.nunjucks"
--   end
-- })


local server_name = "11ty-lsp"
local server_path = vim.fn.expand("$HOME/projects/oss/" .. server_name .. "/server/out/server.js")

vim.lsp.config(server_name, {
  cmd = { "node", server_path, "--stdio" },   -- no stray '--'
  filetypes = { "html", "liquid", "markdown", "njk", "nunjucks", "javascript" },
  root_markers = {
    "eleventy.config.js", "eleventy.config.mjs", "eleventy.config.cjs",
    ".eleventy.js", "package.json", ".git",
  },
  init_options = {
    maxNumberOfProblems = 1000,
    enabledFeatures = { completion = true, diagnostics = true, hover = true },
  },
  settings = {
    [server_name] = {
      maxNumberOfProblems = 1000,
      enabledFeatures = { completion = true, diagnostics = true, hover = true },
    },
  },
})


vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == server_name then
      vim.notify(server_name .. " attached", vim.log.levels.INFO)
    end
  end,
})

vim.lsp.enable(server_name)

-- Optional: Add filetype detection for .njk files
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.njk", "*.nunjucks"},
  callback = function()
    vim.bo.filetype = "nunjucks"
  end
})

