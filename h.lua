hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.animation({
    leaf = "global",
    enabled = true,
    speed = 10,
    bezier = "default",
})
hl.animation({
    leaf = "border",
    enabled = true,
    speed = 5.39,
    bezier = "easeOutQuint",
})
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 4.79,
    bezier = "easeOutQuint",
})
hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 4.1,
    bezier = "easeOutQuint",
    style = "popin 87%",
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 1.49,
    bezier = "linear",
    style = "popin 87%",
})
hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 1.73,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 1.46,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 3.03,
    bezier = "quick",
})
hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 3.81,
    bezier = "easeOutQuint",
})
hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 4,
    bezier = "easeOutQuint",
    style = "fade",
})
hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 1.5,
    bezier = "linear",
    style = "fade",
})
hl.animation({
    leaf = "fadeLayersIn",
    enabled = true,
    speed = 1.79,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "fadeLayersOut",
    enabled = true,
    speed = 1.39,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 1.94,
    bezier = "almostLinear",
    style = "fade",
})
hl.animation({
    leaf = "workspacesIn",
    enabled = true,
    speed = 1.21,
    bezier = "almostLinear",
    style = "fade",
})
hl.animation({
    leaf = "workspacesOut",
    enabled = true,
    speed = 1.94,
    bezier = "almostLinear",
    style = "fade",
})




hl.layer_rule({
    match = { namespace = "match:namespace wofi" },
    -- TODO: manual review — unmapped layer rule: "blur on"
    animation = "off",
})

hl.layer_rule({
    match = { namespace = "match:namespace ^(wofi)$" },
    ignore_alpha = 0.5,
})

hl.layer_rule({
    match = { namespace = "match:namespace waybar" },
    -- TODO: manual review — unmapped layer rule: "blur on"
})

hl.monitor({
    output = "DP-1",
    mode = "3840x2160",
    position = "0x0",
    scale = "1.5",
})

hl.monitor({
    output = "DP-2",
    mode = "3840x2160",
    position = "2560x0",
    scale = "1.5",
})

hl.window_rule({
    match = {
        class = "^(Zotero)$",
        title = ".*Preferences*",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "^(Zotero)$",
        title = ".*Citation*",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "^$",
        xwayland = 1,
        float = 1,
        fullscreen = 0,
        pin = 0,
    },
    no_focus = true,
})

hl.window_rule({
    match = {
        class = "^(org.kde.kcalc)$",
    },
    float = true,
    size = "400 400",
    focus_on_activate = true,
    move = "onscreen cursor -200 -200",
})

hl.window_rule({
    match = {
        class = "^(mpv)$",
    },
    content = "none",
})

hl.window_rule({
    match = {
        class = "^(xwaylandvideobridge)$",
    },
    opacity = "0.0 override",
    no_anim = true,
    no_initial_focus = true,
    max_size = "1 1",
    no_blur = true,
    no_focus = true,
})

hl.window_rule({
    match = {
        title = "^(flameshot)$",
    },
    float = true,
    move = "0 0",
    suppress_event = "fullscreen",
    pin = true,
    fullscreen_state = "0 0",
})

hl.window_rule({
    match = {
        class = "^(wofi)$",
    },
    animation = "off",
})

hl.workspace_rule({
    workspace = "1",
    -- TODO: manual review — workspace field "persistent"
    monitor = "DP-1",
})

hl.workspace_rule({
    workspace = "2",
    -- TODO: manual review — workspace field "persistent"
    monitor = "DP-1",
})

hl.workspace_rule({
    workspace = "3",
    -- TODO: manual review — workspace field "persistent"
    monitor = "DP-1",
})

hl.workspace_rule({
    workspace = "4",
    -- TODO: manual review — workspace field "persistent"
    monitor = "DP-1",
})

hl.workspace_rule({
    workspace = "5",
    -- TODO: manual review — workspace field "persistent"
    monitor = "DP-1",
})

hl.workspace_rule({
    workspace = "6",
    -- TODO: manual review — workspace field "persistent"
    monitor = "DP-1",
})

hl.workspace_rule({
    workspace = "7",
    -- TODO: manual review — workspace field "persistent"
    monitor = "DP-1",
})

hl.workspace_rule({
    workspace = "8",
    -- TODO: manual review — workspace field "persistent"
    monitor = "DP-2",
})

hl.workspace_rule({
    workspace = "9",
    -- TODO: manual review — workspace field "persistent"
    monitor = "DP-2",
})

hl.workspace_rule({
    workspace = "10",
    -- TODO: manual review — workspace field "persistent"
    monitor = "DP-2",
})

hl.workspace_rule({
    workspace = "1",
    default = true,
    monitor = "DP-1",
})

hl.workspace_rule({
    workspace = "8",
    default = true,
    monitor = "DP-2",
})

hl.config({
    animations = {
        enabled = false,
    },
    decoration = {
        blur = {
            enabled = true,
            passes = 2,
            size = 3,
            vibrancy = 0.169600,
        },
        shadow = {
            color = "rgba(1a1a1aee)",
            enabled = true,
            range = 4,
            render_power = 3,
        },
        active_opacity = 1,
        inactive_opacity = 1,
        rounding = 10,
        rounding_power = 2,
    },
    dwindle = {
        force_split = 0,
        preserve_split = true,
    },
    general = {
        allow_tearing = false,
        border_size = 2,
        col = {
            active_border = color14 .. " " .. color3 .. " 45deg",
            inactive_border = color0,
        },
        gaps_in = 4,
        gaps_out = 8,
        layout = "dwindle",
        resize_on_border = true,
    },
    input = {
        touchpad = {
            clickfinger_behavior = true,
            disable_while_typing = true,
            natural_scroll = true,
        },
        follow_mouse = 1,
        kb_layout = "dk",
        sensitivity = 0,
    },
    master = {
        new_status = "master",
    },
    misc = {
        anr_missed_pings = 30,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },
    xwayland = {
        force_zero_scaling = true,
    },
})


