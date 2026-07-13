local servers = {
	"lua_ls",
	"cssls",
	"html",
	"ts_ls",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	"solargraph",
	"ruby_lsp",
	"jinja_lsp"
	-- "ruby_ls",
  	-- "custom_elements_ls"
}


if vim.fn.executable("dotnet") == 1 then
  table.insert(servers, "csharp_ls")
end

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}


local mason_status, mason = pcall(require, 'mason')
if not mason_status then
  return
end

local lsp_status, lspconfig = pcall(require, "lspconfig")
if not lsp_status then
  return
end

local mason_lsp_status, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lsp_status then
  return
end

mason.setup(settings)

-- 1. Register per-server overrides FIRST, before anything gets enabled.
--    vim.lsp.config(name, opts) deep-merges onto nvim-lspconfig's defaults.
for _, name in ipairs(servers) do
  local ok, custom = pcall(require, "user.lsp.settings." .. name)
  if ok then
    vim.lsp.config(name, custom)
  end
end

-- 2. Install + auto-enable. `automatic_enable` defaults to true, so mason
--    calls vim.lsp.enable() for you on each installed server.
require("mason-lspconfig").setup({
  ensure_installed = servers,
  -- automatic_installation is also gone in v2 — ensure_installed covers it.
})
