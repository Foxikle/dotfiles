local helpers = require("scripts.helpers")
local monitor = require("monitors")

-- workspaces
if helpers.get_hostname() == "framework" then
  for i = 1, 10 do
    hl.workspace_rule({ workspace = i, monitor = monitor.MONITORS.primary.output, persistent = true })
  end
else
  for i = 1, 5 do
    hl.workspace_rule({ workspace = i, monitor = monitor.MONITORS.primary.output, persistent = true })
  end

  for i = 6, 10 do
    hl.workspace_rule({ workspace = i, monitor = monitor.MONITORS.secondary.output, persistent = true })
  end
end

-- window rules
local window_rules = {
  { match = { title = "^(btop|update-sys)$" },                           float = true },
  { match = { title = "^(win.*)$", class = "^(.*jetbrains.*)$" },        no_initial_focus = true },
  { match = { title = "^$", class = "^(jetbrains-\\w+)", float = true }, stay_focused = true },
  { match = { title = "^(nvim.*)$", class = "^(kitty)$" },               opacity = "0.8" },
  { match = { class = "^(kitty)$" },                                     opacity = "0.8" },
  { match = { class = "^(kitty)$", title = "^(update-sys)$" } },
  { match = { class = "^(thunar)$" },                                    size = { 800, 400 },    float = true, opacity = "0.8" },
  { match = { class = "^(jetbrains-.*)$" },                              opacity = "0.9" },
}

for _, rule in ipairs(window_rules) do
  hl.window_rule(rule)
end
