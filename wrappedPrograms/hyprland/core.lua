-- ==========================================
-- AMBIENT SYSTEM DESIGN
-- ==========================================
hl.config({
    general = {
        gaps_in = 6,
        gaps_out = 12,
        border_size = 2,
        ["col.active_border"] = "rgba(33ccffff) rgba(00ff99ff) 45deg",
        ["col.inactive_border"] = "rgba(595959aa)",
        layout = "dwindle"
    },
    decoration = {
        rounding = 10,
        blur = {
            enabled = true,
            size = 3,
            passes = 1
        }
    }
})

