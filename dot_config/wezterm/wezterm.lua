-- wezterm.lua - faerieconfig
-- Iosevka Term 13, TokyoNight Night. C-\ is deliberately unbound so tmux
-- can own it as its prefix.

local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night"
-- Iosevka Term for text; Symbols Nerd Font Mono supplies the icon glyphs
-- (nvim-cmp/lspkind, gitsigns, etc.) without changing the text metrics.
config.font = wezterm.font_with_fallback({
	"Iosevka Term",
	"Symbols Nerd Font Mono",
})
config.font_size = 13.0

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.98
config.scrollback_lines = 10000
config.term = "wezterm"

-- Full OSC52 clipboard integration
config.enable_kitty_keyboard = true

config.keys = {
	-- Shift+Insert pastes from the clipboard
	{ key = "Insert", mods = "SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
	-- Explicitly free C-\ so it passes through to tmux
	{ key = "\\", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
}

return config
