-- Window, workspace and layer rules.
-- Rules are anonymous on purpose: named rules are evaluated before anonymous
-- ones and the last matching rule wins, so source order alone decides here.

local c = require("config.colors")

-- ======= Float necessary windows =======
local float_matches = {
    { class = "^(org.pulseaudio.pavucontrol)" },
    { class = "^()$", title = "^(Picture in picture)$" },
    { class = "^()$", title = "^(Save File)$" },
    { class = "^()$", title = "^(Open File)$" },
    { class = "^(LibreWolf)$", title = "^(Picture-in-Picture)$" },
    { class = "^(blueman-manager)$" },
    { class = "^(xdg-desktop-portal-gtk|xdg-desktop-portal-kde|xdg-desktop-portal-hyprland)(.*)$" },
    { class = "^(polkit-gnome-authentication-agent-1|hyprpolkitagent|org.org.kde.polkit-kde-authentication-agent-1)(.*)$" },
    { class = "^(CachyOSHello)$" },
    { class = "^(zenity)$" },
    { class = "^()$", title = "^(Steam - Self Updater)$" },
}
for _, match in ipairs(float_matches) do
    hl.window_rule({ match = match, float = true })
end

-- ======= Opacity =======
hl.window_rule({ match = { class = "^(thunar|nemo)$" },             opacity = "0.92" })
hl.window_rule({ match = { class = "^(discord|armcord|webcord)$" }, opacity = "0.96" })
hl.window_rule({ match = { title = "^(QQ|Telegram)$" },             opacity = "0.95" })
hl.window_rule({ match = { title = "^(NetEase Cloud Music Gtk4)$" }, opacity = "0.95" })

-- ======= General window rules =======
-- Floating video/terminal windows: default placement (the old `move` value was malformed).
hl.window_rule({
    match = { title = "^(Picture-in-Picture)$" },
    float = true,
    size  = { 960, 540 },
})

hl.window_rule({
    match = { title = "^(imv|mpv|danmufloat|termfloat|nemo|ncmpcpp)$" },
    float = true,
    size  = { 960, 540 },
})

hl.window_rule({ match = { title = "^(danmufloat)$" },            pin = true })
hl.window_rule({ match = { title = "^(danmufloat|termfloat)$" },   rounding = 5 })
hl.window_rule({ match = { class = "^(kitty|Alacritty)$" },        animation = "slide right" })
hl.window_rule({ match = { class = "^(org.mozilla.firefox)$" },    no_blur = true })

-- Decorations for floating windows on workspaces 1 to 10
hl.window_rule({
    match        = { float = true, workspace = "w[fv1-10]" },
    border_size  = 2,
    border_color = c.cachylblue,
    rounding     = 8,
})

-- Decorations for tiling windows on workspaces 1 to 10
hl.window_rule({
    match       = { float = false, workspace = "f[1-10]" },
    border_size = 3,
    rounding    = 4,
})

-- ======= Workspace rules =======
-- Smart gaps (replaces the deprecated no_gaps_when_only)
hl.workspace_rule({ workspace = "w[tv1-10]", gaps_out = 5, gaps_in = 3 })
hl.workspace_rule({ workspace = "f[1]",      gaps_out = 5, gaps_in = 3 })

-- ======= Layer rules =======
hl.layer_rule({ match = { namespace = "logout_dialog" }, animation = "slide top" })
hl.layer_rule({ match = { namespace = "waybar" },        animation = "slide down" })
hl.layer_rule({ match = { namespace = "wallpaper" },     animation = "fade 50%" })
