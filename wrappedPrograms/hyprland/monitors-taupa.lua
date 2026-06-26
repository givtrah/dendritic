-- ==========================================
-- DISPLAY CONFIGURATION: taupa
-- ==========================================

-- 1. Physical Monitor Layout
hl.monitor({
  output = "DP-2",
  mode = "3840x2160",
  position = "0x0",
  scale = 1.5
})

-- Portrait rotated monitor with custom padding boundaries
hl.monitor({
  output = "DP-4",
  mode = "3840x2160",
  position = "2560x-560",
  scale = 1.5,
  transform = 1,
  reserved_area = { top = 350 }
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
