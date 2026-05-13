---------------
-- variables --
---------------

local terminal = "kitty"
local mainMod = "SUPER"

-------------
-- monitor --
-------------

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "1",
})

---------
-- env --
---------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("NIXOS_OZONE_WL", "1")

---------------
-- autostart --
---------------

hl.on("hyprland.start", function()
	hl.exec_cmd("caelestia shell -d")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
	hl.exec_cmd("gammastep")
	hl.exec_cmd("mpris-proxy")
	hl.exec_cmd("caelestia resizer -d")
end)

-----------
-- candy --
-----------

hl.config({
	general = {
		gaps_in = 10,
		gaps_out = 10,
		gaps_workspaces = 20,
		border_size = 1,
		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding = 10,
		active_opacity = 1.00,
		inactive_opacity = 0.95,
		shadow = {
			enabled = true,
			range = 20,
			render_power = 3,
			color = 0xee1a1a1a,
		},
		blur = {
			enabled = true,
			size = 8,
			passes = 2,
			ignore_opacity = true,
			new_optimizations = true,
			xray = false,
		},
	},
	animations = {
		enabled = true,
	},
	misc = {
		vrr = 1,
		animate_manual_resizes = false,
		animate_mouse_windowdragging = false,
		disable_hyprland_logo = true,
		force_default_wallpaper = 0,
		allow_session_lock_restore = true,
		middle_click_paste = false,
		focus_on_activate = true,
		session_lock_xray = true,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
	},
	input = {
		kb_layout = "us,ru",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:caps_toggle",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0,
		accel_profile = "flat",
		numlock_by_default = false,
		repeat_delay = 250,
		repeat_rate = 35,
		focus_on_close = 1,
		touchpad = {
			natural_scroll = false,
		},
	},
	binds = {
		scroll_event_delay = 0,
	},
	cursor = {
		hotspot_padding = 1,
    no_hardware_cursors = true,
	},
	dwindle = {
		preserve_split = true,
		smart_split = false,
		smart_resizing = true,
	},
	master = {
		new_status = "master",
	},
	scrolling = {
		fullscreen_on_one_column = true,
		focus_fit_method = 1,
		column_width = 0.5,
		follow_focus = true,
	},
	group = {
		col = {
			border_active = "rgba(33ccffee)",
			border_inactive = "rgba(595959aa)",
			border_locked_active = "rgba(33ccffee)",
			border_locked_inactive = "rgba(595959aa)",
		},
		groupbar = {
			font_size = 15,
			gradients = true,
			height = 25,
			indicator_height = 0,
			gaps_in = 3,
			gaps_out = 3,
		},
	},
})

----------------
-- animations --
----------------

hl.curve("emphasizedDecel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("emphasizedAccel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })
hl.curve("specialWorkSwitch", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 6, bezier = "standard" })
hl.animation({ leaf = "fade", enabled = true, speed = 6, bezier = "standard" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 6, bezier = "standard" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "emphasizedDecel" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "emphasizedAccel" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 6, bezier = "standard" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 5, bezier = "emphasizedDecel", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 4, bezier = "emphasizedAccel", style = "slide" })
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 5, bezier = "standard" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "standard" })
hl.animation({
	leaf = "specialWorkspace",
	enabled = true,
	speed = 4,
	bezier = "specialWorkSwitch",
	style = "slidefadevert 15%",
})

------------------
-- window rules --
------------------

local suppressMaximizeRule = hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
	no_focus = true,
})

hl.window_rule({ name = "float-qt-dialogs", match = { title = "(Select|Open)( a)? (File|Folder)(s)?" }, float = true })
hl.window_rule({ name = "float-file-progress", match = { title = "File (Operation|Upload)( Progress)?" }, float = true })
hl.window_rule({ name = "float-properties", match = { title = ".* Properties" }, float = true })
hl.window_rule({ name = "float-save-as", match = { title = "Save As" }, float = true })
hl.window_rule({ name = "float-zenity", match = { class = "zenity" }, float = true })
hl.window_rule({ name = "float-yad", match = { class = "yad" }, float = true })
hl.window_rule({ name = "float-blueman", match = { class = "blueman-manager" }, float = true })
hl.window_rule({ name = "float-feh", match = { class = "feh" }, float = true })
hl.window_rule({ name = "float-imv", match = { class = "imv" }, float = true })
hl.window_rule({
	name = "float-gnome-settings",
	match = { class = "org.gnome.Settings" },
	float = true,
	size = "60% 70%",
	move = "center 1",
})
hl.window_rule({
	name = "float-pavucontrol",
	match = { class = "org.pulseaudio.pavucontrol" },
	float = true,
	size = "60% 70%",
	move = "center 1",
})

hl.window_rule({ name = "ws-sysmon", match = { class = "btop" }, workspace = "special:sysmon" })
hl.window_rule({
	name = "ws-music",
	match = { class = "Spotify|feishin|Cider|com.github.th_ch.youtube_music" },
	workspace = "special:music",
})
hl.window_rule({
	name = "ws-comm",
	match = { class = "discord|vesktop|equibop|whatsapp" },
	workspace = "special:communication",
})
hl.window_rule({ name = "ws-todo", match = { class = "Todoist" }, workspace = "special:todo" })

hl.window_rule({
	name = "pip-float",
	match = { title = "Picture(-| )in(-| )[Pp]icture" },
	float = true,
	pin = true,
	keep_aspect_ratio = true,
})
hl.window_rule({ name = "pip-move", match = { title = "Picture(-| )in(-| )[Pp]icture" }, move = "100%-w-2% 100%-w-3%" })

hl.window_rule({ name = "steam-rounding", match = { class = "steam" }, rounding = 10 })
hl.window_rule({ name = "steam-friends", match = { class = "steam", title = "Friends List" }, float = true })

hl.window_rule({ name = "opaque-foot", match = { class = "foot" }, opaque = true })
hl.window_rule({ name = "opaque-swappy", match = { class = "swappy" }, opaque = true })

hl.window_rule({
	name = "center-floating",
	match = { float = true, xwayland = false },
	move = "center 1",
})

hl.window_rule({
	name = "float-ueberzug",
	match = { class = "^(ueberzugpp_.*)$" },
	float = true,
	no_initial_focus = true,
})

--------------
-- keybinds --
--------------

local workspace_keys = { "Q", "W", "E", "R", "T", "A", "S", "D", "F", "G" }
for i, key in ipairs(workspace_keys) do
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + X", hl.dsp.window.close())
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("caelestia shell drawers toggle launcher"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + P", hl.dsp.window.fullscreen())
-- hl.bind(mainMod .. " + U", hl.dsp.group.ungroup())
hl.bind(mainMod .. " + Comma", hl.dsp.group.toggle())
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- hl.bind("ALT + Tab", hl.dsp.group.cycle({ direction = "next" }))
-- hl.bind("SHIFT + ALT + Tab", hl.dsp.group.cycle({ direction = "prev" }))

hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("caelestia shell session"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("caelestia shell sidebar"))
hl.bind("CTRL + ALT + C", hl.dsp.exec_cmd("caelestia shell notifs clear"))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("caelestia shell showall"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("caelestia shell lock"))
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("caelestia shell -d"))

hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd("caelestia toggle sysmon"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("caelestia toggle music"))
-- hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("caelestia toggle specialws"))
hl.bind(mainMod .. " + B", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + ALT + B", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind("CTRL + ALT + Escape", hl.dsp.exec_cmd("app2unit -- qps"))
hl.bind("CTRL + ALT + V", hl.dsp.exec_cmd("app2unit -- pavucontrol"))

hl.bind("Print", hl.dsp.exec_cmd("~/.config/hypr/screenshot.sh"))
-- hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd("caelestia record -s"))
hl.bind("CTRL + ALT + R", hl.dsp.exec_cmd("caelestia record"))
hl.bind("SUPER + SHIFT + ALT + R", hl.dsp.exec_cmd("caelestia record -r"))
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard"))
hl.bind(mainMod .. " + Period", hl.dsp.exec_cmd("pkill fuzzel || caelestia emoji -p"))

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 10%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })


hl.layer_rule({
	name = "no-anim-caelestia-border",
	match = { namespace = "^caelestia-(border-exclusion|area-picker)$" },
	no_anim = true,
})
hl.layer_rule({
	name = "anim-caelestia-drawers",
	match = { namespace = "^caelestia-(drawers|background)$" },
	animation = "fade",
})
