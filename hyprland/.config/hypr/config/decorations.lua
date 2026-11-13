hl.config({
    decoration = {
        active_opacity   = 1,
        inactive_opacity = 0.8,
        rounding         = 6,

        blur = {
            size              = 15,
            passes            = 2, -- more passes = more resource intensive
            xray              = true,
            new_optimizations = true,
            vibrancy          = 0.1696,
        },

        shadow = {
            enabled = false,
        },
    },
})
