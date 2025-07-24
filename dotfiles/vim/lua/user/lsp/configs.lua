local _, lsp_installer = pcall(require, "nvim-lsp-installer")

local lspconfig = require("lspconfig")

local servers = {
  "solargraph",
  "ruby_ls",
  "jsonls",
  "jinja_lsp",
  "sumneko_lua",
  'bashls',
  'cssls',
  'html',
  'jsonls',
  'tsserver',
  'emmet_ls',
  'vimls',
  'yamlls',
}


if vim.fn.executable("dotnet") == 1 then
  table.insert(servers, "csharp_ls")
end

lsp_installer.setup {
	ensure_installed = servers
}


local opts = {
	on_attach = require("user.lsp.handlers").on_attach,
	capabilities = require("user.lsp.handlers").capabilities,
}
for _, server in pairs(servers) do
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
	 	opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
	end
	lspconfig[server].setup(opts)
end
