-- ==========================================
-- SYSTEM AUTOSTART ACTIONS
-- ==========================================

-- Executed once on desktop initialization
hl.on("hyprland.start", function()
    -- Authentication Agent - should start automagically
--    hl.exec_cmd("systemctl --user start hyprpolkitagent")

    -- Security, Wallet & Pam Handlers
    hl.exec_cmd("/run/current-system/sw/libexec/pam_kwallet_init")
    hl.exec_cmd("kwallet-query -l kdewallet &> /dev/null")

    -- Services & Cloud Clients
    hl.exec_cmd("maestral start &> /dev/null")
    hl.exec_cmd("maestral_qt")

    -- Applets & System Monitors
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("remmina -i")

    -- Notifications & Clipboard
    hl.exec_cmd("swaync")
    hl.exec_cmd("swaync-client -df")
    hl.exec_cmd("wl-clip-persist --clipboard regular & clipse -listen")

    -- Wallpapers, Themes, & UI Elements
    hl.exec_cmd("wall-random")
    hl.exec_cmd("waybar-reload")
end)

-- Executed every single time Hyprland reloads its configuration state
hl.on("hyprland.reload", function()
    hl.exec_cmd("waybar-reload")
end)


-- potentially missing 1 line of dbus-update and 2 lines of systemctl (should be handled by uwsm)
