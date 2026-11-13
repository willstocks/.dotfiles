-- Environment variables. The third argument (true) also exports the variable
-- to the systemd/dbus activation environment (the old `envd`).

hl.env("HYPRCURSOR_SIZE", "24", true)
hl.env("XCURSOR_SIZE", "24", true)
hl.env("QT_CURSOR_SIZE", "24", true)
hl.env("AQ_DRM_DEVICES", "/dev/dri/intel-igpu", true)

-- If you need to scale things like Steam, uncomment (adjust GDK_SCALE):
-- hl.config({ xwayland = { force_zero_scaling = true } })
-- hl.env("GDK_SCALE", "1.25")
