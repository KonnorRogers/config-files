local servers = {
	"lua_ls",
	"cssls",
	"html",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	-- "solargraph",
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


local status, mason = pcall(require, 'mason')
if not status then
  return
end

local status, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not status then
  return
end

mason.setup(settings)

mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local _, lspconfig = pcall(require, "lspconfig")

local opts = {
	on_attach = require("user.lsp.handlers").on_attach,
	capabilities = require("user.lsp.handlers").capabilities,
}


require('lspconfig-bundler').setup()
lspconfig.solargraph.setup(opts)

for _, server in pairs(servers) do
  local extended_opts = {}

	server = vim.split(server, "@")[1]

	local status_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)

	if status_ok then
          extended_opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(extended_opts)
end
