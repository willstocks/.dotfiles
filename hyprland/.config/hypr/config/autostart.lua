-- Autostart. hyprland.start fires once per session (like exec-once), not on reload.
-- exec_cmd runs through `sh -c`, so no trailing `&` is needed.

local d = require("config.defaults")

hl.on("hyprland.start", function()
    hl.exec_cmd([[swaybg -o \* -i /usr/share/wallpapers/cachyos-wallpapers/wave2.png -m fill]])
    hl.exec_cmd("waybar")
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd("mako")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd([[bash -c "mkfifo /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob && tail -f /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob | wob & disown"]])
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("hyprpm reload -n")

    -- Slow app launch fix: disabled, Hyprland exports these to systemd/dbus itself.
    -- Uncomment if apps (portals, Flatpak, GTK/Qt) start launching slowly again.
    -- hl.exec_cmd("systemctl --user import-environment")
    -- hl.exec_cmd("dbus-update-activation-environment --systemd --all")

    -- Idle configuration
    hl.exec_cmd(d.idlehandler)

    -- Initially launch terminal
    hl.exec_cmd(d.terminal)
end)
