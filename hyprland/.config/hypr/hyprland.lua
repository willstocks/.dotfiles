-- CachyOS Hyprland configuration (Lua)
-- Each require() runs in its own scope, so an error in one module does not
-- stop the others from loading.

-- Environment must be set before anything else (before the display server starts).
require("config.environment")

require("config.monitor")
require("config.general")
require("config.decorations")
require("config.animations")
require("config.input")
require("config.keybinds")
require("config.windowrules")
require("config.autostart")

-- Local overrides: create config/user.lua to customise without editing the
-- files above. pcall keeps a missing file from aborting this config.
pcall(require, "config.user")
