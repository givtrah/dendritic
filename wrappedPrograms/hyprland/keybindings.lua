-- ==========================================
-- KEYBINDS VIA LUA FUNCTIONS
-- ==========================================
local mainMod = "SUPER"

-- Core Application Dispatches
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close)
hl.bind(mainMod .. " + M", hl.dsp.exit)

-- Generate numerical hooks 1-9 for navigation and moving windows
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.workspace.focus(tostring(i)))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move_to_workspace(tostring(i)))
end

