-- Default programs and shared commands.
-- Usage: local d = require("config.defaults")

return {
    terminal    = "kitty",
    filemanager = "dolphin",
    browser     = "zen-browser",
    applauncher = "rofi -show drun - run-command {cmd}",
    switcher    = "rofi -show window -window-thumbnail -show-icons -run-command {cmd}",
    idlehandler = [[swayidle -w timeout 300 'swaylock -f -c 000000' before-sleep 'swaylock -f -c 000000']],
    capturing   = [[grim -g "$(slurp)" - | swappy -f -]],
    scripts     = "~/.config/hypr/scripts",
}
