-- ==========================================
-- HYPRLAND LUA KEYBINDINGS CONFIGURATION
-- ==========================================

local mainMod = "SUPER"

-- Core Application Handlers (Replacing variables)
local terminal    = "kitty"
local menu        = "rofi -show drun"
local filemanager = "nemo"
local browser     = "firefox"

-- ------------------------------------------
-- STANDARD BINDINGS (hl.bind)
-- ------------------------------------------

-- Applications & Essential Utilities
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Q", hl.dsp.window.close)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(filemanager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))

-- Custom Scripts & Reloads
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("wall-random"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("waybar-reload"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("flameshot gui"))

-- Layouts & Window States
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen(0))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen(1))
hl.bind(mainMod .. " + V", hl.dsp.window.toggle_floating)

-- Core Session State Controls
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + ESCAPE", hl.dsp.exit)

-- Directional Container Selection
hl.bind(mainMod .. " + left", hl.dsp.window.move_focus("l"))
hl.bind(mainMod .. " + right", hl.dsp.window.move_focus("r"))
hl.bind(mainMod .. " + up", hl.dsp.window.move_focus("u"))
hl.bind(mainMod .. " + down", hl.dsp.window.move_focus("d"))

-- Directional Container Swapping
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.swap("l"))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap("r"))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.swap("u"))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.swap("d"))

-- Relative Workspace Navigation
hl.bind(mainMod .. " + comma", hl.dsp.workspace.focus("m-1"))
hl.bind(mainMod .. " + period", hl.dsp.workspace.focus("m+1"))
hl.bind(mainMod .. " + mouse_down", hl.dsp.workspace.focus("e+1"))
hl.bind(mainMod .. " + mouse_up", hl.dsp.workspace.focus("e-1"))

-- Special Workspace Layer (Scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move_to_workspace("special:magic"))

-- Dynamic Workspace Target Generators (Loop loops workspaces 1 to 10)
for i = 1, 10 do
    local ws = tostring(i)
    local key = i == 10 and "0" or tostring(i)
    
    -- Focus numeric workspaces
    hl.bind(mainMod .. " + " .. key, hl.dsp.workspace.focus(ws))
    -- Dispatch focused container to target index
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move_to_workspace(ws))
end

-- ------------------------------------------
-- LOCKED / AUDIO INPUT BINDINGS (hl.bindel / hl.bindl)
-- ------------------------------------------

-- Audio Controls (Locked and repeating elements)
hl.bindel(" + XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bindel(" + XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bindel(" + XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bindel(" + XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

-- Asahi / Unified Screen Brightness Modifiers
hl.bindel(" + XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"))
hl.bindel(" + XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"))

-- Media Player Hooks (One-shot locked execution)
hl.bindl(" + XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bindl(" + XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bindl(" + XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bindl(" + XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- Window Resize Hooks
hl.bind(mainMod .. " + minus", hl.dsp.window.resize("active", "-100 0"))
hl.bind(mainMod .. " + equal", hl.dsp.window.resize("active", "100 0"))
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.resize("active", "0 -100"))
hl.bind(mainMod .. " + SHIFT + equal", hl.dsp.window.resize("active", "0 100"))

-- ------------------------------------------
-- MOUSE GESTURE BINDINGS (hl.bindm)
-- ------------------------------------------
hl.bindm(mainMod .. " + mouse:272", hl.dsp.window.move)
hl.bindm(mainMod .. " + mouse:273", hl.dsp.window.resize)

-- ==========================================
-- STASHED / COMMENTED-OUT BINDINGS
-- ==========================================
-- hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("$random_wall &> /dev/null"))
-- hl.bind(mainMod .. " + J", hl.dsp.layout.toggle_split) -- dwindle
-- hl.bind(mainMod .. " + P", hl.dsp.layout.pseudo) -- dwindle
-- hl.bind(" + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
-- hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
-- hl.bind("CTRL + PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
-- hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprpicker -a"))
-- hl.bind("CTRL + " .. mainMod .. " + V", hl.dsp.exec_cmd("ghostty --class clipse -e clipse"))
