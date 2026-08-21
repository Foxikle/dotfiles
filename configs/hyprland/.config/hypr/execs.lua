-- execs.lua (Things run once on startup!)

local autostarts = {
  { "~/.config/hypr/xdg-portal-hyprland" },
  { "waybar" },
  { "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" },
  { "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1" },
  { "mako" },
  { "blueman-applet" },
  { "nm-applet --indicator" },
  { "hypridle" },
  { "hyprpaper" },
  { "wl-paste --watch cliphist store" },
  { "rm \"$HOME/.cache/cliphist/db\"" },
}

hl.on("hyprland.start", function()
  for _, auto_start in ipairs(autostarts) do
    hl.exec_cmd(auto_start[1], auto_start[2])
  end
end)
