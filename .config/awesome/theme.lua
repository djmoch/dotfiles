--
-- ~/.config/awesome/theme.lua
--
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local xtheme = xresources.get_current_theme()
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local awful = require("awful")
local themes_path = gfs.get_themes_dir()

local theme = dofile(themes_path.."default/theme.lua")

theme.font          = "sans 9"

theme.bg_normal     = xtheme.color8
theme.bg_focus      = xtheme.color7
theme.bg_urgent     = xtheme.color4
theme.bg_minimize   = xtheme.color0
theme.bg_systray    = xtheme.color8

theme.fg_normal     = xtheme.background
theme.fg_focus      = xtheme.foreground
theme.fg_urgent     = xtheme.background
theme.fg_minimize   = xtheme.background

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(1)
theme.border_normal = xtheme.color8
theme.border_focus  = xtheme.color4
theme.border_marked = xtheme.color5

theme.hotkeys_bg            = xtheme.color8
theme.hotkeys_fg            = xtheme.background
theme.hotkeys_modifiers_fg  = xtheme.color6

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_focus
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

theme = theme_assets.recolor_layout(theme, theme.fg_normal)
theme = theme_assets.recolor_titlebar(theme, theme.fg_normal, "normal")
theme = theme_assets.recolor_titlebar(theme, theme.bg_normal, "focus")

-- Variables set for theming the menu:
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

theme.wallpaper = function (s) awful.spawn('my wallpaper') end

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

theme.wibar_height = dpi(16)
theme.titlebar_height = dpi(16)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Arc"

return theme
