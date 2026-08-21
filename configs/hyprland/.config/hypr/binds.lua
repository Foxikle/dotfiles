-- binds.lua - Key binds

local mod = "SUPER"

local mod_binds = {
  { "Q",          hl.dsp.exec_cmd("kitty") },
  { "F4",         hl.dsp.window.close() },
  { "M",          hl.dsp.exec_cmd("wlogout --protocol layer-shell") },
  { "SHIFT + M",  hl.dsp.exit() },
  { "E",          hl.dsp.exec_cmd("thunar") },
  { "V",          hl.dsp.window.float({ action = "toggle" }) },
  { "SPACE",      hl.dsp.exec_cmd("wofi") },
  { "P",          hl.dsp.window.pseudo() },
  { "S",          hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | swappy -f -") },
  { "ALT + V",    hl.dsp.exec_cmd("cliphist list | wofi --show dmenu -H 600 -W 900 | cliphist decode | wl-copy") },
  { "L",          hl.dsp.exec_cmd("hyprlock") },
  { "left",       hl.dsp.focus({ direction = "left" }) },
  { "right",      hl.dsp.focus({ direction = "right" }) },
  { "up",         hl.dsp.focus({ direction = "up" }) },
  { "down",       hl.dsp.focus({ direction = "down" }) },
  { "mouse_up",   hl.dsp.focus({ workspace = "e-1" }) },
  { "mouse_down", hl.dsp.focus({ workspace = "e+1" }) },
}

local repeating_binds = {
  { mod .. "+ SHIFT + left",  hl.dsp.window.resize({ x = -10, y = 0, relative = true }) },
  { mod .. "+ SHIFT + right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }) },
  { mod .. "+ SHIFT + up",    hl.dsp.window.resize({ x = 0, y = -10, relative = true }) },
  { mod .. "+ SHIFT + down",  hl.dsp.window.resize({ x = 0, y = 10, relative = true }) },
}

local locked_binds = {
  { "XF86AudioNext",  hl.dsp.exec_cmd("playerctl next") },
  { "XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause") },
  { "XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause") },
  { "XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous") },
}

local locked_repeating_binds = {
  { "XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+") },
  { "XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-") },
  { "XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+") },
  { "XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-") },
  { "XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") },
  { "XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") },
}

local mouse_binds = {
  { mod .. "+ mouse:272", hl.dsp.window.drag() },
  { mod .. "+ mouse:273", hl.dsp.window.resize() }
}

-- workspace keybinds (1-10 takes you to that worksapce, shift + 1-10 moves active window there)
for i = 1, 10 do
  local key = 1 % 10
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- modded binds
for _, bind in ipairs(mod_binds) do
  hl.bind(mod .. " + " .. bind[1], bind[2])
end

-- repeating binds
for _, bind in ipairs(repeating_binds) do
  hl.bind(bind[1], bind[2], { repeating = true })
end

-- locked binds
for _, bind in ipairs(locked_binds) do
  hl.bind(bind[1], bind[2], { locked = true })
end

-- locked and repeating binds
for _, bind in ipairs(locked_repeating_binds) do
  hl.bind(bind[1], bind[2], { locked = true, repeating = true })
end

-- mouse binds
for _, bind in ipairs(mouse_binds) do
  hl.bind(bind[1], bind[2], { mouse = true })
end
