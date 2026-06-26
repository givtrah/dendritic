-- ==========================================
-- DISPLAY CONFIGURATION: taupa
-- ==========================================

-- 1. Physical Monitor Layout
hl.monitor({
  name = "DP-2",
  resolution = "3840x2160",
  position = "0x0",
  scale = 1.5
})

-- Portrait rotated monitor with custom padding boundaries
hl.monitor({
  name = "DP-4",
  resolution = "3840x2160",
  position = "2560x-560",
  scale = 1.5,
  transform = 1,
  addreserved = "350,0,0,0" -- Equivalent to: top, bottom, left, right padding
})

-- 2. Persistent Workspaces & Defaults
for i = 1, 7 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "DP-2", persistent = true })
end
for i = 8, 10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "DP-4", persistent = true })
end

-- Focus targets
hl.workspace_rule({ workspace = "1", monitor = "DP-2", default = true })
hl.workspace_rule({ workspace = "8", monitor = "DP-4", default = true })
