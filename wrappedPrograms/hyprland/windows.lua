-- ==========================================
-- HYPRLAND WINDOW & LAYER RULES
-- ==========================================

hl.config({
    -- --------------------------------------
    -- WINDOW RULES (MATCH CRITERIA)
    -- --------------------------------------
    windowrule = {
        -- Zotero popups
        "float on, match:class ^(Zotero)$, match:title .*Preferences*",
        "float on, match:class ^(Zotero)$, match:title .*Citation*",

        -- Fix some dragging issues with XWayland
        "no_focus on,match:class ^$,match:xwayland 1,match:float 1,match:fullscreen 0,match:pin 0",

        -- Kcalc configuration fixes
        "float on, match:class ^(org.kde.kcalc)$",
        "size 400 400, match:class ^(org.kde.kcalc)$",
        "focus_on_activate on, match:class ^(org.kde.kcalc)$",
        "move onscreen cursor -200 -200, match:class ^(org.kde.kcalc)$",

        -- Fix mpv no video only audio bug
        "content none, match:class ^(mpv)$",

        -- Hide and optimize xwaylandvideobridge
        "opacity 0.0 override, match:class ^(xwaylandvideobridge)$",
        "no_anim on, match:class ^(xwaylandvideobridge)$",
        "no_initial_focus on, match:class ^(xwaylandvideobridge)$",
        "max_size 1 1, match:class ^(xwaylandvideobridge)$",
        "no_blur on, match:class ^(xwaylandvideobridge)$",
        "no_focus on, match:class ^(xwaylandvideobridge)$",

        -- Fix Flameshot utility behaviors
        "float on, match:title ^(flameshot)$",
        "move 0 0, match:title ^(flameshot)$",
        "suppress_event fullscreen, match:title ^(flameshot)$",
        "pin on, match:title ^(flameshot)$",
        "fullscreen_state 0 0, match:title ^(flameshot)$",

        -- Application Menu Overrides
        "animation off, match:class ^(wofi)$",
    },

    -- --------------------------------------
    -- LAYER RULES (WAYBAR & MENUS)
    -- --------------------------------------
    layerrule = {
        -- Wofi UI optimizations
        "blur on, match:namespace wofi",
        "animation off, match:namespace wofi",
        "ignore_alpha 0.5, match:namespace ^(wofi)$",

        -- Waybar backdrop panel styling
        "blur on, match:namespace waybar",
    },
})

-- ==========================================
-- STASHED / REFERENCE RULES
-- ==========================================
--[[
    "tile, class:^(chromium)$",
    "float, class:^(org.pulseaudio.pavucontrol|blueberry.py)$",
    "float, class:^(steam)$",
    "fullscreen, class:^(com.libretro.RetroArch)$",
    "float, class:(clipse)",
    "size 622 652, class:(clipse)",
    "stayfocused, class:(clipse)",
--]]
