-- This needs to come first.
local handlers_status, handlers = pcall(require, "user.lsp.handlers")


pcall(require, "lspconfig")

if handlers_status then
  handlers.setup()
end

pcall(require, "user.lsp.mason")


vim.g["ruby_host_prog"] = "$HOME/.asdf/shims/neovim-ruby-host"

local server_path = vim.fn.expand("~/projects/oss/haxe-language-server/bin/server.js")

if vim.fn.filereadable(server_path) == 1 then
  vim.lsp.config("haxe_language_server", {
    cmd = { "node", server_path },
    filetypes = { "haxe" },
    root_markers = { "build.hxml", "main.hxml", ".git" },
    init_options = { displayArguments = { "main.hxml" } },
    settings = {
      haxe = {},  -- presence of this is what triggers didChangeConfiguration
    },
  })
  vim.lsp.enable("haxe_language_server")
end


-- install drenv
-- if vim.fn.executable("drenv") == 0 then
--   vim.fn.system({
--     "curl",
--     "-fsSL",
--     "drenv.org/install.sh",
--     "-o",
--     "install.sh",
--   })
-- end

-- Prefer the spike binary while it exists; fall back to `drenv` once
-- `drenv lsp` ships in the main binary.
local drenv = vim.fn.exepath("drenv-lsp-spike")
if drenv == "" then
  drenv = vim.fn.exepath("drenv")
end

if drenv ~= "" then
  vim.lsp.config("drenv", {
    cmd = { drenv, "lsp" },
    filetypes = { "ruby" },
    root_markers = {
      "dragonruby",
      "dragonruby.exe",
      "drenv.toml",
      ".git",
    },
  })

  vim.lsp.enable("drenv")
end

