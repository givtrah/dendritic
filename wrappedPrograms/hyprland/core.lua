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
    -- MISCELLANEOUS & DIAGNOSTICS
    -- --------------------------------------
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        anr_missed_pings = 30, -- Application not responding threshold
    },
})
