-- Sets up environment variables for Hyprland
local envs = {
  { k = "QT_QPA_PLATFORM",                 v = "wayland" },
  { k = "ELECTRON_OZONE_PLATFORM_HINT",    v = "auto" },
  { k = "MOZ_ENABLE_WAYLAND",              v = "1" },
  { k = "PROTON_ENABLE_WAYLAND",           v = "1" },
  { k = "STEAM_FORCE_DESKTOPUI_SCALING",   v = "1" },
  { k = "QT_SCALE_FACTOR_ROUNTING_POLICY", v = "RoundPreferFloor" },
  { k = "GTK_USE_PORTAL",                  v = "1" },
  { k = "XCURSOR_SIZE",                    v = "24" },
  { k = "HYPRCURSOR_THEME",                v = "xcursor-pro-hyprcursor" },
  { k = "WLR_NO_HARDWARE_CURSORS",         v = "1" },
  { k = "XDG_CURRENT_DESKTOP",             v = "Hyprland" },
  { k = "XDG_SESSION_TYPE",                v = "wayland" },
  { k = "XDG_SESSION_DESKTOP",             v = "Hyprland" },
  { k = "GDK_BACKEND",                     v = "wayland" },
}

for _, env in ipairs(envs) do
  hl.env(env.k, env.v)
end
