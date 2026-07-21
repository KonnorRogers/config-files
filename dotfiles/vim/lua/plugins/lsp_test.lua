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

-- Optional: Add filetype detection for .njk files
local function detect(path, bufnr)
  local name = vim.fn.fnamemodify(path, ':t')
  local parts = vim.split(name, '.', { plain = true })

  -- rebuild the name with njk/jinja tokens removed
  local is_template, kept = false, {}
  for i, p in ipairs(parts) do
    if i > 1 and (p == 'njk' or p == 'jinja') then
      is_template = true
    else
      table.insert(kept, p)
    end
  end
  if not is_template then return nil end  -- not a template; let builtin handle it

  -- ask Neovim what the *inner* file would be
  local inner = vim.filetype.match({ filename = table.concat(kept, '.') })
  return inner and ('jinja.' .. inner) or 'jinja.html'
end

vim.filetype.add({
  pattern = {
    ['.*%.njk.*']   = { detect, { priority = 10 } },
    ['.*%.jinja.*'] = { detect, { priority = 10 } },
  },
})

local server_name = "11ty-lsp"
local server_path = vim.fn.expand("$HOME/projects/webawesome-repos/" .. server_name .. "/server/out/server.js")

local root_markers = {
  "eleventy.config.js", "eleventy.config.mjs", "eleventy.config.cjs",
  ".eleventy.js", "package.json", ".git",
}

local cfg = {
  cmd = { "node", server_path, "--stdio" },
  filetypes = { "jinja", "html", "liquid", "markdown", "njk", "nunjucks", "javascript" },
  root_markers = root_markers,
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
}

-- vim.lsp.config(server_name, cfg)
-- vim.lsp.enable(server_name)

-- Attach for template buffers. Autocmd patterns match the FULL &filetype string,
-- so a dotted "jinja.html" won't match a bare "jinja" pattern — we split it ourselves,
-- the same way ftplugin/syntax loaders handle dotted filetypes.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local is_template = false
    for part in vim.gsplit(ft, ".", { plain = true }) do
      if part == "jinja" or part == "njk" or part == "nunjucks" then
        is_template = true
        break
      end
    end
    if not is_template then return end

    vim.lsp.start(
      vim.tbl_extend("force", cfg, {
        name = server_name,
        root_dir = vim.fs.root(args.buf, root_markers),
      }),
      { bufnr = args.buf }
    )
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == server_name then
      vim.notify(server_name .. " attached", vim.log.levels.INFO)
    end
  end,
})

