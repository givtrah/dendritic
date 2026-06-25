-- ==========================================
-- SYSTEM AUTOSTART ACTIONS
-- ==========================================
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar --log-level error")
    hl.exec_cmd("pywal -R")
end)
