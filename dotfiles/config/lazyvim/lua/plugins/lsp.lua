return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- use the real server names you see failing in :Mason / :LspInfo
      omnisharp = { mason = false }, -- .NET
      elixirls = { mason = false },
      erlangls = { mason = false },
      fsautocomplete = { mason = false },
    },
    -- turn off ghost variable annotations
    inlay_hints = { enabled = false },
  },
}
