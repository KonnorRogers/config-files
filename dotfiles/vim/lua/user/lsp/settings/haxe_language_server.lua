local opts = {
  default_config = {
    init_options = {
      displayArguments = { "build.hxml" },
    },
  };
}

local server_path = vim.fn.expand("~/projects/oss/haxe-language-server/bin/server.js")

-- Bail out if the server hasn't been built yet
if vim.fn.filereadable(server_path) == 0 then
  return opts
end

opts.default_config.cmd = { "node", server_path }

return opts
