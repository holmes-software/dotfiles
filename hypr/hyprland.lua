-- Hyprland Lua config converted from the legacy hyprland.conf setup.
-- See https://wiki.hypr.land/Configuring/Start/

local home = os.getenv("HOME")

local default_colors = {
    background = "#0C0000",
    foreground = "#FEEDCD",
    color0 = "#0C0000",
    color1 = "#8D7D83",
    color2 = "#E45F03",
    color3 = "#BA9879",
    color4 = "#DAB7BC",
    color5 = "#C2C4BC",
    color6 = "#FDCB71",
    color7 = "#F6DDB0",
    color8 = "#AC9A7B",
    color9 = "#8D7D83",
    color10 = "#E45F03",
    color11 = "#BA9879",
    color12 = "#DAB7BC",
    color13 = "#C2C4BC",
    color14 = "#FDCB71",
    color15 = "#F6DDB0",
}

local function load_wallust_colors()
    local path = home .. "/.cache/wallust/colors-hyprland.lua"
    local file = io.open(path, "r")

    if file == nil then
        return default_colors
    end

    file:close()

    local ok, colors = pcall(dofile, path)
    if not ok then
        error("Failed to load Wallust Hyprland colors from " .. path .. ": " .. tostring(colors))
    end

    if type(colors) ~= "table" then
        error("Wallust Hyprland colors must return a table: " .. path)
    end

    return colors
end

local colors = load_wallust_colors()

------------------
---- MONITORS ----
------------------

hl.config({
    render = {
        cm_auto_hdr = true,
    },

    debug = {
        full_cm_proto = true,
    },
})

hl.monitor({
    output = "DP-1",
    mode = "1920x1080@60",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@60",
    position = "1920x0",
    scale = 1,
})

hl.monitor({
    output = "DP-3",
    mode = "3440x1440@175",
    position = "200x1080",
    scale = 1,
    bitdepth = 10,
    cm = "hdr",
    supports_wide_color = 1,
    supports_hdr = 1,
})

for workspace = 1, 10 do
    hl.workspace_rule({
        workspace = tostring(workspace),
        monitor = workspace <= 5 and "DP-1" or "HDMI-A-1",
    })
end

--------------------------------
---- ENVIRONMENT VARIABLES ----
--------------------------------

-- Virtual Machines
-- hl.env("WLR_NO_HARDWARE_CURSORS", "1")
-- hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")
hl.env("XCURSOR_SIZE", "24")
hl.env("GTK_THEME", "Adwaita:dark")

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("~/dotfiles/hypr/scripts/xdg.sh")
    hl.exec_cmd("dunst")
    hl.exec_cmd("hyprctl setcursor Moga-Cursor 24")
    hl.exec_cmd("~/dotfiles/gtk/gtk.sh")
    hl.exec_cmd("~/dotfiles/hypr/scripts/lockscreentime.sh")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("awww query || awww-daemon")
    hl.exec_cmd("~/dotfiles/scripts/wallpaper.sh init")
    hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 2,
        border_size = 2,
        col = {
            active_border = {
                colors = { colors.color7, colors.color4 },
                angle = 45,
            },
            inactive_border = "rgba(595959aa)",
        },
        layout = "dwindle",
    },

    decoration = {
        rounding = 10,

        blur = {
            enabled = true,
            size = 3,
            passes = 5,
            new_optimizations = true,
            ignore_opacity = true,
            xray = false,
            popups = true,
        },

        active_opacity = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 15,
            render_power = 5,
            color = 0x80000000,
        },
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },

    cursor = {
        inactive_timeout = 3,
    },

    input = {
        kb_layout = "us",
        follow_mouse = 1,
        touchpad = {
            natural_scroll = true,
        },
        sensitivity = -0.9,
        numlock_by_default = true,
    },

    animations = {
        enabled = true,
    },
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 6,
    bezier = "default",
    style = "slidevert",
})

---------------------
---- KEYBINDINGS ----
---------------------

local function bind(keys, dispatcher, opts)
    return hl.bind(keys, dispatcher, opts)
end

-- General
local main_mod = "SUPER"
bind(main_mod .. " + RETURN", hl.dsp.exec_cmd("ghostty -e zellij"))
bind(main_mod .. " + Q", hl.dsp.window.close())
bind(main_mod .. " + F", hl.dsp.window.fullscreen())
bind(main_mod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
bind(main_mod .. " + M", hl.dsp.exec_cmd("~/dotfiles/hypr/scripts/togglemonitor.sh"))
bind(main_mod .. " + ALT + M", hl.dsp.exec_cmd("~/dotfiles/hypr/scripts/togglemouse.sh"))
bind(main_mod .. " + B", hl.dsp.exec_cmd("vivaldi-stable"))
bind(main_mod .. " + D", hl.dsp.exec_cmd("vesktop"))
bind(main_mod .. " + ALT + D", hl.dsp.exec_cmd("webcord"))
bind(main_mod .. " + S", hl.dsp.exec_cmd("steam"))
bind(main_mod .. " + ALT + E", hl.dsp.exec_cmd("rofi -modi emoji -show emoji"))
bind(main_mod .. " + ALT + S", hl.dsp.exec_cmd("~/dotfiles/hypr/scripts/specialchars.sh"))
bind(main_mod .. " + SHIFT + C", hl.dsp.exec_cmd("~/dotfiles/hypr/scripts/colorgrabber.sh"))

-- Focus
bind(main_mod .. " + H", hl.dsp.focus({ direction = "left" }))
bind(main_mod .. " + L", hl.dsp.focus({ direction = "right" }))
bind(main_mod .. " + K", hl.dsp.focus({ direction = "up" }))
bind(main_mod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move
bind(main_mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
bind(main_mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
bind(main_mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
bind(main_mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Resize
bind(main_mod .. " + CTRL + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
bind(main_mod .. " + CTRL + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
bind(main_mod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
bind(main_mod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))

-- Switch workspaces
bind(main_mod .. " + ALT + H", hl.dsp.focus({ workspace = "e-1" }))
bind(main_mod .. " + ALT + L", hl.dsp.focus({ workspace = "e+1" }))

-- Special workspace
bind(main_mod .. " + X", hl.dsp.workspace.toggle_special())
bind(main_mod .. " + SHIFT + X", hl.dsp.window.move({ workspace = "special" }))

-- Tabbed groups
bind(main_mod .. " + G", hl.dsp.group.toggle())
bind(main_mod .. " + ALT + TAB", hl.dsp.group.next())

-- Select and move to workspaces
for workspace = 1, 10 do
    local key = workspace % 10
    bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
    bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

-- Mouse bindings
bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Scripts
bind("Print", hl.dsp.exec_cmd("~/dotfiles/hypr/scripts/screenshot.sh"))
bind(main_mod .. " + P", hl.dsp.exec_cmd("wlogout"))
bind(main_mod .. " + W", hl.dsp.exec_cmd("~/dotfiles/scripts/wallpaper.sh"))
bind(main_mod .. " + SHIFT + W", hl.dsp.exec_cmd("~/dotfiles/scripts/wallpaper.sh select"))
bind(main_mod .. " + ALT + W", hl.dsp.exec_cmd("~/dotfiles/scripts/wallpaper.sh remote"))
bind(main_mod .. " + SPACE", hl.dsp.exec_cmd("rofi -show drun"))
bind(main_mod .. " + E", hl.dsp.exec_cmd("~/dotfiles/scripts/filemanager.sh"))
bind(main_mod .. " + ALT + C", hl.dsp.exec_cmd("~/dotfiles/scripts/cliphist.sh"))
bind(main_mod .. " + T", hl.dsp.exec_cmd("~/dotfiles/waybar/themeswitcher.sh"))
bind(main_mod .. " + TAB", hl.dsp.exec_cmd("~/dotfiles/scripts/toggleaudiosource.sh"))

-- Misc
bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -q s +10%"), { repeating = true })
bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -q s 10%-"), { repeating = true })
bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"))
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"))
bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"))

--------------------
---- WINDOWRULES ----
--------------------

hl.window_rule({
    name = "steam-news-float",
    match = { title = "Volume Control" },
    float = true,
})

hl.window_rule({
    name = "volume-control-float",
    match = { title = "Steam - News" },
    float = true,
})

hl.window_rule({
    name = "space-craft-fullscreen",
    match = { title = "Space Craft" },
    workspace = "6",
    fullscreen = true,
})

hl.window_rule({
    name = "planet-viewer-fullscreen",
    match = { title = "Planet Viewer" },
    workspace = "6",
    fullscreen = true,
})
