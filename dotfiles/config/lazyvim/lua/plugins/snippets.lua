return {
  "saghen/blink.cmp",
  opts = {
    sources = {
      providers = {
        snippets = {
          opts = {
            search_paths = { vim.fn.stdpath("config") .. "/snippets" },
            -- recreates your UltiSnips `extends` directives
            extended_filetypes = {
              eruby = { "ruby" },
              markdown = { "javascript" },
              mdx = { "javascript" },
              html = { "javascript", "sabio" },
              php = { "html", "javascript", "sabio" },
            },
          },
        },
      },
    },
  },
}
