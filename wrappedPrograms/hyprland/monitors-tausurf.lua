-- ==========================================
-- DISPLAY CONFIGURATION: Laptop Profiles
-- ==========================================

-- Fallback dynamic layout discovery
hl.monitor({ name = "", resolution = "preferred", position = "auto", scale = "auto" })

-- 2. Persistent Workspaces & Defaults
for i = 1, 7 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1", persistent = true })
end
for i = 8, 10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "DP-2", persistent = true })
end

-- Focus targets
hl.workspace_rule({ workspace = "1", monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "8", monitor = "DP-2", default = true })
