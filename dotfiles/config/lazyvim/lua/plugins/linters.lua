return {
  "mfussenegger/nvim-lint",
  opts = function(_, opts)
    opts.linters_by_ft = {} -- wipe all of them, or:
    -- opts.linters_by_ft.markdown = nil
    -- opts.linters_by_ft.dockerfile = nil
  end,
}
