require("env")
require("monitors")
require("rules")
require("execs")
require("rules")
require("binds")

-- general config stuff
local terminal = "kitty"
local fileManager = "thunar"
local menu = "wofi"

hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 2,
    border_size = 2,
    col = {
      active_border = "rgb(D3C6AA)",
      inactive_border = "rgba(56635F77)"
    },
    resize_on_border = true,
    layout = "dwindle"
  },
  decoration = {
    rounding = 2,
    blur = {
      enabled = true,
      size = 7,
      passes = 4
    },
    shadow = {
      enabled = true,
      range = 4,
      render_power = 4,
      color = "rgba(1a1a1aee)"
    },
  },
  animations = {
    enabled = true
  },
  dwindle = {
    preserve_split = true,
  },
  master = {
    new_status = "master",
  },
  cursor = {
    no_hardware_cursors = true,
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})
