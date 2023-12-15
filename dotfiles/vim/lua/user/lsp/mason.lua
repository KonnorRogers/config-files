local servers = {
	"lua_ls",
	"cssls",
	"html",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	"solargraph",
	"ruby_ls",
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

mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})


local opts = {
	on_attach = require("user.lsp.handlers").on_attach,
	capabilities = require("user.lsp.handlers").capabilities,
}

mason_lspconfig.setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        local extended_opts = {}

	      local status_ok, conf_opts = pcall(require, "user.lsp.settings." .. server_name)

	      if status_ok then
          extended_opts = vim.tbl_deep_extend("force", conf_opts, opts)
	      end

	      lspconfig[server_name].setup(extended_opts)
    end,
}
