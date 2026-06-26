-- ==========================================
-- HYPRLAND CORE LOOK & FEEL CONFIGURATION
-- ==========================================

hl.config({
    -- --------------------------------------
    -- HARDWARE INPUT & GESTURES
    -- --------------------------------------
    input = {
        kb_layout = "dk",
        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            disable_while_typing = true,
            natural_scroll = true,
            clickfinger_behavior = true,
        },
    },

    gestures = {
        -- workspace_swipe = false,
    },

    -- --------------------------------------
    -- GENERAL VISUALS
    -- --------------------------------------
    general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 2,
        
        -- Pywal dynamic color string parsing
--        ["col.active_border"] = "$color14 $color3 45deg",
--        ["col.inactive_border"] = "$color0",

        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    -- --------------------------------------
    -- WINDOW DECORATIONS & BLUR
    -- --------------------------------------
    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1,
        inactive_opacity = 1,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            -- ignore_window = true,
            color = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            vibrancy = 0.1696,
        },
    },

    -- --------------------------------------
    -- ANIMATIONS DESIGN LAYER
    -- --------------------------------------
    animations = {
        enabled = false, -- Disabled as requested :)

        -- Bezier Curve Hooks
-- hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
-- hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } }) 
-- hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
-- hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } }
-- hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })


        bezier = {
            "easeOutQuint,0.23,1,0.32,1",
            "easeInOutCubic,0.65,0.05,0.36,1",
            "linear,0,0,1,1",
            "almostLinear,0.5,0.5,0.75,1.0",
            "quick,0.15,0,0.1,1",
        },

        -- Structural Animation Tweaks
        animation = {
            "global, 1, 10, default",
            "border, 1, 5.39, easeOutQuint",
            "windows, 1, 4.79, easeOutQuint",
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%",
            "windowsOut, 1, 1.49, linear, popin 87%",
            "fadeIn, 1, 1.73, almostLinear",
            "fadeOut, 1, 1.46, almostLinear",
            "fade, 1, 3.03, quick",
            "layers, 1, 3.81, easeOutQuint",
            "layersIn, 1, 4, easeOutQuint, fade",
            "layersOut, 1, 1.5, linear, fade",
            "fadeLayersIn, 1, 1.79, almostLinear",
            "fadeLayersOut, 1, 1.39, almostLinear",
            "workspaces, 1, 1.94, almostLinear, fade",
            "workspacesIn, 1, 1.21, almostLinear, fade",
            "workspacesOut, 1, 1.94, almostLinear, fade",
        },
    },

    -- --------------------------------------
    -- WINDOW MANAGER TILING LAYOUTS
    -- --------------------------------------
    dwindle = {
        -- pseudotile = true,
        preserve_split = true,
        force_split = 0, -- 0 = follow mouse, 1 = always left, 2 = always right
    },

    master = {
        new_status = "master",
    },

    -- --------------------------------------
    -- MISCELLANEOUS & DIAGNOSTICS
    -- --------------------------------------
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        anr_missed_pings = 30, -- Application not responding threshold
    },
})
