local opts = {
  filetypes = { "ruby", "eruby", "rails", "haml" },
  root_dir = function(bufnr, on_dir)
    -- DragonRuby tree? bail out and let drenv own it.
    if vim.fs.root(bufnr, { "dragonruby", "dragonruby.exe", "drenv.toml", "mygame" }) then
      return
    end
    -- Otherwise only attach in a real Gemfile project.
    local root = vim.fs.root(bufnr, { "Gemfile", ".git" })
    if root then on_dir(root) end
  end,
}

return opts
