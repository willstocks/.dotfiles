-- General, group, misc, render and layout settings.

local c = require("config.colors")

hl.config({
    general = {
        gaps_in     = 3,
        gaps_out    = 5,
        border_size = 3,
        layout      = "scrolling", -- dwindle | master | scrolling | monocle

        col = {
            active_border   = { colors = { c.catpactivefrom, c.catpactiveto }, angle = 45 },
            inactive_border = c.catpinactive,
        },

        snap = {
            enabled = true,
        },
    },

    group = {
        col = {
            border_active          = c.cachydgreen,
            border_inactive        = c.cachylgreen,
            border_locked_active   = c.cachymgreen,
            border_locked_inactive = c.cachydblue,
        },

        groupbar = {
            font_family = "FiraCode Nerd Font",
            text_color  = c.cachydblue,
            col = {
                active          = c.cachydgreen,
                inactive        = c.cachylgreen,
                locked_active   = c.cachymgreen,
                locked_inactive = c.cachydblue,
            },
        },
    },

    misc = {
        font_family          = "FiraCode Nerd Font",
        splash_font_family   = "FiraCode Nerd Font",
        disable_hyprland_logo = true,
        background_color     = c.cachydblue,
        enable_swallow       = true,
        swallow_regex        = "^(cachy-browser|firefox|nautilus|nemo|thunar|btrfs-assistant.)$",
        focus_on_activate    = true,
        vrr                  = 2,
        col = {
            splash = c.cachylgreen,
        },
    },

    render = {
        direct_scanout        = 1,
        new_render_scheduling = true,
    },

    -- Layout-specific settings (scrolling is active; the others are kept for
    -- per-workspace layouts or switching back).
    scrolling = {
        column_width             = 0.5,
        fullscreen_on_one_column = true,
        focus_fit_method         = 1,
    },

    dwindle = {
        special_scale_factor = 0.8,
        preserve_split       = true,
        force_split          = 2,
    },

    master = {
        new_status           = "master",
        special_scale_factor = 0.8,
    },
})

-- 3-finger horizontal swipe switches workspaces.
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
