{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    systemd.enable = true;
    extraConfig = ''
      hl.env("LIBVA_DRIVER_NAME", "nvidia")
      hl.env("XDG_SESSION_TYPE", "wayland")
      hl.env("GBM_BACKEND", "nvidia-drm")
      hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
      hl.env("WLR_NO_HARDWARE_CURSORS", "1")
      hl.env("NVD_BACKEND", "direct")
      hl.env("XCURSOR_THEME", "macOS")
      hl.env("XCURSOR_SIZE", "24")
      hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
      hl.env("QT_QPA_PLATFORM", "wayland:xcb")
      hl.env("GDK_BACKEND", "wayland,x11")
      hl.env("SDL_VIDEODRIVER", "wayland")
      hl.env("CLUTTER_BACKEND", "wayland")

      hl.config({
        cursor = {
          no_hardware_cursors = true,
        },
        input = {
          kb_layout = "us,ru",
          follow_mouse = 1,
          sensitivity = -0.4,
          kb_options = "grp:alt_shift_toggle",
        },
        general = {
          gaps_in = 5,
          gaps_out = 10,
          border_size = 2,
	  col = {
            active_border   = { colors = {"rgba(7aa2f7aa)", "rgba(bb9af7aa)"}, angle = 45 },
            inactive_border = "rgba(565f8966)",
          },
	  layout = "dwindle",
          allow_tearing = false,
        },
        decoration = {
          rounding = 13,
	  blur = {
	    enabled = false,
	  },
	},
        animations = {
          enabled = true,
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
          mouse_move_enables_dpms = true,
          key_press_enables_dpms = true,
          vrr = 1,
          background_color = "rgba(1a1b26ff)",
        },
        debug = {
          vfr = true,
        },
      })

      hl.curve("smoothOut", { type = "bezier", points = { {0.36, 0}, {0.66, -0.56} } })
      hl.curve("smoothIn",  { type = "bezier", points = { {0.25, 1}, {0.5,  1   } } })
      hl.curve("overshot",  { type = "bezier", points = { {0.13, 0.99}, {0.29, 1.1} } })
      hl.animation({ leaf = "windows",    enabled = true, speed = 5,  bezier = "overshot",  style = "slide" })
      hl.animation({ leaf = "windowsOut", enabled = true, speed = 4,  bezier = "smoothOut", style = "slide" })
      hl.animation({ leaf = "border",     enabled = true, speed = 10, bezier = "default" })
      hl.animation({ leaf = "fade",       enabled = true, speed = 10, bezier = "smoothIn" })
      hl.animation({ leaf = "fadeDim",    enabled = true, speed = 10, bezier = "smoothIn" })
      hl.animation({ leaf = "workspaces", enabled = true, speed = 6,  bezier = "overshot",  style = "slide" })

      hl.monitor({ output = "HDMI-A-1", mode = "1440x900@59.89", position = "0x0", scale = 1 })
      hl.on("hyprland.start", function()
        hl.dispatch(hl.dsp.exec_cmd("caelestia shell -d"))
        hl.dispatch(hl.dsp.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1"))
        hl.dispatch(hl.dsp.exec_cmd("nm-applet --indicator"))
        hl.dispatch(hl.dsp.exec_cmd("/usr/lib/kdeconnectd"))
        hl.dispatch(hl.dsp.exec_cmd("kdeconnect-indicator"))
        hl.dispatch(hl.dsp.exec_cmd("hypridle"))
        hl.dispatch(hl.dsp.exec_cmd("wl-paste --type text --watch cliphist store"))
        hl.dispatch(hl.dsp.exec_cmd("wl-paste --type image --watch cliphist store"))
        hl.dispatch(hl.dsp.exec_cmd("dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland"))
        hl.dispatch(hl.dsp.exec_cmd("systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"))
      end)

      local mainMod = "SUPER"

      hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("kitty"))
      hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nemo"))
      hl.bind(mainMod .. " + SPACE", hl.dsp.global("caelestia:launcher"))
      hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
      hl.bind(mainMod .. " + Z", hl.dsp.global("caelestia:launcher"))
      hl.bind(mainMod .. " + PERIOD", hl.dsp.exec_cmd("caelestia emoji --picker"))

      hl.bind(mainMod .. " + C", hl.dsp.window.close())
      hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
      hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
      hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
      hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

      hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
      hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
      hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
      hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))

      for i = 1, 6 do
        hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
        hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
      end


      hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit())

      hl.bind("Print",        hl.dsp.global("caelestia:screenshot"))
      hl.bind("SHIFT + Print", hl.dsp.global("caelestia:screenshotFreeze"))

      hl.bind("XF86AudioMute",    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
      hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
      hl.bind("XF86Calculator",   hl.dsp.exec_cmd("gnome-calculator"))
      hl.bind("XF86Mail",         hl.dsp.exec_cmd("thunderbird"))
      hl.bind("XF86AudioPlay",    hl.dsp.global("caelestia:mediaPlayPause"))
      hl.bind("XF86AudioPause",   hl.dsp.global("caelestia:mediaPlayPause"))
      hl.bind("XF86AudioNext",    hl.dsp.global("caelestia:mediaNext"))
      hl.bind("XF86AudioPrev",    hl.dsp.global("caelestia:mediaPrevious"))
      hl.bind("XF86AudioStop",    hl.dsp.global("caelestia:mediaStop"))

      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
      
      hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"))
      hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
      hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"))
      hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"))
      hl.bind("XF86AudioStop",  hl.dsp.exec_cmd("playerctl stop"))
      
      hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
      hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
    '';
  };
}
