# Monitors
local M = {}
local helpers = require("scripts.helpers")
local hostname = helpers.get_hostname()

local laptop_monitor = { output = "eDP-1", mode = "preferred", position = "0x0", scale = "1" }
local monitors = {
  arch = {
    primary = { output = "DP-2", mode = "1920x1080@60", position = "0x0", scale = "1" },
    secondary = { output = "HDMI-A-1", mode = "1920x1080@60", position = "1920x0", scale = "1" },
  },
  framework = {
    primary = laptop_monitor,
    secondary = laptop_monitor,
  }
}

local active = monitors[hostname] or monitors["arch"]

hl.monitor(active.primary)
hl.monitor(active.secondary)

M.MONITORS = active

return M;
