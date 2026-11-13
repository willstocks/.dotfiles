-- Keybinds.
-- NOTE: bind callbacks run on the compositor event loop and must never block;
-- use hl.dsp.exec_cmd for anything external.

local d = require("config.defaults")

local mainMod = "SUPER"

-- hl.bind wrapper: map(keys, dispatcher, description?, flags?)
local function map(keys, dispatcher, desc, flags)
    local opts = { description = desc }
    for k, v in pairs(flags or {}) do
        opts[k] = v
    end
    return hl.bind(keys, dispatcher, opts)
end

local function mod(keys)
    return mainMod .. " + " .. keys
end

local exec = hl.dsp.exec_cmd

-- ======= Applications =======
map(mod("RETURN"), exec(d.terminal),    "Opens your preferred terminal emulator")
map(mod("E"),      exec(d.filemanager), "Opens your preferred file manager")
map(mod("A"),      exec(d.capturing),   "Screen capture selection")
map(mod("Z"),      exec(d.browser),     "Opens the browser")
map(mod("SPACE"),  exec(d.applauncher), "Runs your application launcher")
map(mod("TAB"),    exec(d.switcher),    "Window switcher")
map(mod("SHIFT + P"), exec("gnome-calculator"), "Runs the calculator application")
map(mod("L"),      exec("swaylock-fancy -e -K -p 10 -f Fira-Code-Regular"), "Lock the screen")
map(mod("O"),      exec("killall -SIGUSR2 waybar"), "Reload/restart Waybar")

-- ======= Window state =======
map(mod("C"), hl.dsp.window.close(), "Closes (not kill) current window")
map(mod("SHIFT + M"), exec('loginctl terminate-user ""'), "Exits Hyprland by terminating the user session")
map(mod("V"), hl.dsp.window.float({ action = "toggle" }), "Toggle floating/tiling")
map(mod("F"), hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), "Toggle fullscreen")
map(mod("Y"), hl.dsp.window.pin(), "Pin window (shows on all workspaces)")

-- ======= Grouping =======
map(mod("K"),           hl.dsp.group.toggle(), "Toggle group mode")
map(mod("SHIFT + TAB"), hl.dsp.group.next(),   "Switch to the next window in the group")

-- ======= Gaps =======
local function set_gaps(out, inn)
    return function()
        hl.config({ general = { gaps_out = out, gaps_in = inn } })
    end
end
map(mod("SHIFT + G"), set_gaps(5, 3), "Set CachyOS default gaps")
map(mod("G"),         set_gaps(0, 0), "Remove gaps between windows")

-- ======= Volume / brightness (repeat + work while locked) =======
local sound = { repeating = true, locked = true }
map("XF86AudioRaiseVolume", exec("bash " .. d.scripts .. "/volume up"),   nil, sound)
map("XF86AudioLowerVolume", exec("bash " .. d.scripts .. "/volume down"), nil, sound)
map("XF86AudioMute",        exec("bash " .. d.scripts .. "/volume mute"), nil, sound)
map("XF86MonBrightnessUp",   exec("brightnessctl s +5%"), nil, sound)
map("XF86MonBrightnessDown", exec("brightnessctl s 5%-"), nil, sound)

-- ======= Playback =======
map("XF86AudioPlay", exec("playerctl play-pause"), "Toggles play/pause")
map("XF86AudioNext", exec("playerctl next"),       "Next track")
map("XF86AudioPrev", exec("playerctl previous"),   "Previous track")

-- ======= Mouse: move / resize =======
hl.bind(mod("mouse:272"), hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod("mouse:273"), hl.dsp.window.resize(), { mouse = true })

-- ======= Move windows / focus (scrolling layout) =======
local directions = {
    left  = { dir = "left",  key = "l" },
    right = { dir = "right", key = "r" },
    up    = { dir = "up",    key = "u" },
    down  = { dir = "down",  key = "d" },
}
for key, v in pairs(directions) do
    map(mod("SHIFT + " .. key), hl.dsp.window.move({ direction = v.dir }), "Move active window " .. v.dir)
    map(mod(key), hl.dsp.layout("focus " .. v.key), "Move focus " .. v.dir)
end

-- ======= Resizing =======
-- resize deltas, shared by the resize submap and the quick-resize binds
local resize = {
    right = { 15, 0 },  l = { 15, 0 },
    left  = { -15, 0 }, h = { -15, 0 },
    up    = { 0, -15 }, k = { 0, -15 },
    down  = { 0, 15 },  j = { 0, 15 },
}

-- Resize mode: SUPER+R, then arrows or hjkl, escape to leave.
map(mod("R"), hl.dsp.submap("resize"), "Activates window resizing mode")
hl.define_submap("resize", function()
    for key, delta in pairs(resize) do
        hl.bind(key, hl.dsp.window.resize({ x = delta[1], y = delta[2], relative = true }),
            { description = "Resize (resizing mode)" })
    end
    hl.bind("escape", hl.dsp.submap("reset"), { description = "Ends window resizing mode" })
end)

-- Quick resize (SUPER is included because CTRL+SHIFT is used for word selection in editors)
for key, delta in pairs(resize) do
    map(mod("CTRL + SHIFT + " .. key), hl.dsp.window.resize({ x = delta[1], y = delta[2], relative = true }), "Resize")
end

-- ======= Workspaces =======
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    map(mod(key),                hl.dsp.focus({ workspace = i }), "Switch to workspace " .. i)
    map(mod("CTRL + " .. key),   hl.dsp.window.move({ workspace = i }), "Move window and switch to workspace " .. i)
    map(mod("SHIFT + " .. key),  hl.dsp.window.move({ workspace = i, follow = false }), "Move window silently to workspace " .. i)
end

map(mod("CTRL + left"),  hl.dsp.window.move({ workspace = "-1" }), "Move window to the previous workspace")
map(mod("CTRL + right"), hl.dsp.window.move({ workspace = "+1" }), "Move window to the next workspace")

map(mod("PERIOD"),     hl.dsp.focus({ workspace = "e+1" }), "Scroll through workspaces incrementally")
map(mod("COMMA"),      hl.dsp.focus({ workspace = "e-1" }), "Scroll through workspaces decrementally")
map(mod("mouse_down"), hl.dsp.focus({ workspace = "e+1" }), "Scroll through workspaces incrementally")
map(mod("mouse_up"),   hl.dsp.focus({ workspace = "e-1" }), "Scroll through workspaces decrementally")
map(mod("slash"),      hl.dsp.focus({ workspace = "previous" }), "Switch to the previous workspace")

-- Special workspaces (scratchpads)
map(mod("minus"), hl.dsp.window.move({ workspace = "special:special" }), "Move active window to the special workspace")
map(mod("equal"), hl.dsp.workspace.toggle_special("special"),            "Toggle the special workspace")
map(mod("F1"),    hl.dsp.workspace.toggle_special("scratchpad"),         "Toggle the scratchpad")
map(mod("ALT + SHIFT + F1"),
    hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }),
    "Move active window to the scratchpad")

-- ======= Bind behaviour =======
hl.config({
    binds = {
        allow_workspace_cycles            = true,
        workspace_back_and_forth          = 1,
        workspace_center_on               = 1,
        movefocus_cycles_fullscreen       = true,
        window_direction_monitor_fallback = true,
    },
})
