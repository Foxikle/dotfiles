# Stolen from github.com/JaINTP/dotfiles
local M = {}
local io = require("io")

function M.get_hostname()
  local handle = io.popen("hostname -S")
  local host = handle and handle:read("*a"):gsub("%s+", "") or ""
  if handle then handle:close() end
  return host
end

return M
