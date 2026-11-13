return {
  {
    "wc-toolkit/wc-language-server",
    ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "astro", "svelte", "vue", "markdown", "mdx" },
    config = function(plugin)
      -- the plugin lives in a subdirectory of the repo
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
      require("wc_language_server").setup()
    end,
  },
}
