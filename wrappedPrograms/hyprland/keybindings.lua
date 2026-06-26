-- ==========================================
-- HYPRLAND LUA KEYBINDINGS CONFIGURATION
-- ==========================================

local mainMod = "SUPER"

-- Core Application Handlers (Replacing variables)
local terminal    = "kitty"
local menu        = "rofi -show drun"
local filemanager = "nemo"
local browser     = "firefox"

local color0 = "rgba(7,16,31,1.0)" 
local color14 = "rgba(212,154,156,1.0)"
local color3 = "rgba(204,61,82,1.0)"

-- Source: ~/.cache/wal/colors-hyprland.conf — convert this file to Lua and ensure it is on Lua's package.path.
-- require("colors-hyprland")     


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
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen(1))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

-- Core Session State Controls
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + ESCAPE", hl.dsp.exit())

-- Directional Container Selection - this might be potentially wrong!
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Directional Container Swapping
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.swap({ direction = "d" }))

-- Relative Workspace Navigation
hl.bind(mainMod .. " + comma", hl.dsp.focus({ workspace = -1 }))
hl.bind(mainMod .. " + period", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Special Workspace Layer (Scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Dynamic Workspace Target Generators (Loop loops workspaces 1 to 10)
for i = 1, 10 do
    local ws = tostring(i)
    local key = i == 10 and "0" or tostring(i)

    -- Focus numeric workspaces
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = ws}))
    -- Dispatch focused container to target index
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws}))
end

-- ------------------------------------------
-- LOCKED / AUDIO INPUT BINDINGS (hl.bindel / hl.bindl)
-- ------------------------------------------

-- Audio Controls (Locked and repeating elements)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })

-- Asahi / Unified Screen Brightness Modifiers
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Media Player Hooks (One-shot locked execution)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Window Resize Hooks
hl.bind(mainMod .. " + minus", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
hl.bind(mainMod .. " + equal", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
hl.bind(mainMod .. " + SHIFT + equal", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))

-- ------------------------------------------
-- MOUSE GESTURE BINDINGS (hl.bindm)
-- ------------------------------------------
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

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
