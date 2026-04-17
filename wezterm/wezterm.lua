function GetOS()
	local fh = assert(io.popen("uname -o 2>/dev/null", "r"))
	if fh then
		return fh:read() or "Windows"
	end

	return ""
end

local wezterm = require("wezterm")
local config = {}
local act = wezterm.action

-- config.color_scheme = "Gruvbox dark, hard (base16)"
-- config.color_scheme = "Gruvbox Material (Gogh)"
-- config.color_scheme = "Monokai (dark) (terminal.sexy)"
-- config.color_scheme = "tokyonight_night"
config.color_scheme = "Vs Code Dark+ (Gogh)"
-- config.color_scheme = "Classic Dark (base16)"
-- config.color_scheme = "carbonfox"
-- config.color_scheme = "terafox"
-- config.color_scheme = "Kanagawa Dragon (Gogh)"

config.automatically_reload_config = true

config.hide_tab_bar_if_only_one_tab = true

config.enable_scroll_bar = false
config.scrollback_lines = 10240

if GetOS() == "Darwin" then
	config.font_size = 14
elseif GetOS() == "GNU/Linux" then
	config.font_size = 11
end

config.default_cursor_style = "BlinkingBlock"

config.window_padding = {
	left = 10,
	right = 10,
	top = 20,
	bottom = "1cell",
}

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

config.harfbuzz_features = { "calt=0", "clig=0", "liga=0", "zero" }

config.font = wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font Mono",
	"JetBrains Mono",
})

config.notification_handling = "NeverShow"

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = "v",
		mods = "LEADER",
		action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	{
		key = "h",
		mods = "LEADER",
		action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "x", mods = "LEADER", action = act({ CloseCurrentPane = { confirm = true } }) },
	{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "s", mods = "LEADER", action = act.PaneSelect({ mode = "SwapWithActive" }) },

	{ key = "{", mods = "CTRL|SHIFT", action = act.ScrollByPage(-0.5) },
	{ key = "}", mods = "CTRL|SHIFT", action = act.ScrollByPage(0.5) },
	{ key = "`", mods = "LEADER", action = act.ActivateTabRelative(1) },
	-- { key = "{", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
	-- { key = "}", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },

	{ key = "h", mods = "CTRL|SHIFT", action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "CTRL|SHIFT", action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "CTRL|SHIFT", action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "CTRL|SHIFT", action = act({ ActivatePaneDirection = "Right" }) },

	{ key = "h", mods = "CTRL|SHIFT|ALT", action = act({ AdjustPaneSize = { "Left", 10 } }) },
	{ key = "j", mods = "CTRL|SHIFT|ALT", action = act({ AdjustPaneSize = { "Down", 10 } }) },
	{ key = "k", mods = "CTRL|SHIFT|ALT", action = act({ AdjustPaneSize = { "Up", 10 } }) },
	{ key = "l", mods = "CTRL|SHIFT|ALT", action = act({ AdjustPaneSize = { "Right", 10 } }) },
	{
		key = "e",
		mods = "LEADER",
		action = wezterm.action.EmitEvent("trigger-vim-with-scrollback"),
	},

	-- {
	-- 	key = "h",
	-- 	mods = "CTRL|SHIFT",
	-- 	action = act.Multiple({
	-- 		act({ ActivatePaneDirection = "Left" }),
	-- 		act.TogglePaneZoomState,
	-- 	}),
	-- },
	-- {
	-- 	key = "j",
	-- 	mods = "CTRL|SHIFT",
	-- 	action = act.Multiple({
	-- 		act({ ActivatePaneDirection = "Down" }),
	-- 		act.TogglePaneZoomState,
	-- 	}),
	-- },
	-- {
	-- 	key = "k",
	-- 	mods = "CTRL|SHIFT",
	-- 	action = act.Multiple({
	-- 		act({ ActivatePaneDirection = "Up" }),
	-- 		act.TogglePaneZoomState,
	-- 	}),
	-- },
	-- {
	-- 	key = "l",
	-- 	mods = "CTRL|SHIFT",
	-- 	action = act.Multiple({
	-- 		act({ ActivatePaneDirection = "Right" }),
	-- 		act.TogglePaneZoomState,
	-- 	}),
	-- },
}

for i = 1, 8 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|ALT",
		action = act.ActivateTab(i - 1),
	})
end

config.mouse_bindings = {
	-- Copy text on selection
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act({
			CompleteSelection = "ClipboardAndPrimarySelection",
		}),
	},
	-- Paste on right click
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act.PasteFrom("Clipboard"),
	},
	-- Scroll Up
	{
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		mods = "NONE",
		action = act.ScrollByLine(-2), -- Change to -2 or -3 if -1 is too slow
		alt_screen = false, -- IMPORTANT: Only do this for the scrollback
	},
	-- Scroll Down
	{
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		mods = "NONE",
		action = act.ScrollByLine(2), -- Change to 2 or 3 if 1 is too slow
		alt_screen = false,
	},
}

wezterm.on("trigger-vim-with-scrollback", function(window, pane)
	local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)
	local name = os.tmpname()
	local f = io.open(name, "w+")
	if f then
		f:write(text)
		f:flush()
		f:close()
	end

	window:perform_action(
		act.SpawnCommandInNewTab({
			-- This launches a shell that runs nvim, then deletes the file ONLY after nvim quits
			args = { "bash", "-c", 'nvim "$1"; rm "$1"', "bash", name },
		}),
		pane
	)
end)

return config

-- if wezterm.GLOBAL.zoom_state == nil then
-- 	wezterm.GLOBAL.zoom_state = false
-- end
--
-- local toggle_zoom = wezterm.action_callback(function(window, pane)
-- 	if wezterm.GLOBAL.zoom_state then
-- 		wezterm.GLOBAL.zoom_state = false
-- 	else
-- 		wezterm.GLOBAL.zoom_state = true
-- 	end
-- 	window:perform_action(act.TogglePaneZoomState, pane)
-- end)
--
-- local function switch_pane_and_maintain_zoom(direction)
-- 	return act.Multiple({
-- 		act({ ActivatePaneDirection = direction }),
-- 		wezterm.action_callback(function(window, pane)
-- 			if wezterm.GLOBAL.zoom_state then
-- 				window:perform_action(act.TogglePaneZoomState, pane)
-- 			end
-- 		end),
-- 	})
-- end
--
-- { key = "z", mods = "LEADER", action = toggle_zoom },
-- { key = "j", mods = "CTRL|SHIFT", action = switch_pane_and_maintain_zoom("Down") },
-- { key = "k", mods = "CTRL|SHIFT", action = switch_pane_and_maintain_zoom("Up") },
-- { key = "l", mods = "CTRL|SHIFT", action = switch_pane_and_maintain_zoom("Right") },
-- { key = "h", mods = "CTRL|SHIFT", action = switch_pane_and_maintain_zoom("Left") },
