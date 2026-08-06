local mod = "SUPER"
hl.config({
  input = {
    kb_layout = "us";
    kb_options = "grp:alt_space_toggle";
    repeat_rate = 25;
    repeat_delay = 300;
  },
})

hl.bind(mod .. " + L", hl.dsp.exec_cmd(hyprlock))
hl.bind(mod .. " + Delete", hl.dsp.exec_cmd(hyprshutdown))
hl.bind(mod .. " + Shift + Delete", hl.dsp.exec_cmd(systemctl shutdown -h now))
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + Space", hl.dsp.exec_cmd("pkill tofi-drun || tofi-drun | xargs hyprctl dispatch exec --"))
hl.bind(mod .. " + Shift + Space", hl.dsp.exec_cmd("pkill tofi-run || tofi-run | xargs hyprctl dispatch exec --"))
hl.bind(mod .. " + K", hl.dsp.exec_cmd("kitty"))
hl.bind(mod .. " + E", hl.dsp.exec_cmd("kitty yazi"))
hl.bind("Control_L&Shift_L, Escape", hl.dsp.exec_cmd("kitty btop"))
hl.bind(mod .. " + Print", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mod .. " + Shift + Print", hl.dsp.exec_cmd("hyprshot -m output --clipboard-only"))
hl.bind(mod .. " + Shift + Control + Print", hl.dsp.exec_cmd("hyprshot -m window --clipboard-only"))
hl.bind(mod .. " + Equal", hl.dsp.exec_cmd("hyprctl keyword monitor \"eDP-1, preferred, auto, 1.5\""))
hl.bind(mod .. " + Minus", hl.dsp.exec_cmd("hyprctl keyword monitor \"eDP-1, preferred, auto, 1\""))
hl.bind(mod .. " + Return", hl.dsp.window.fullscreen())
hl.bind(mod .. " + W", hl.dsp.window.float())
hl.bind(mod .. " + Left", hl.dsp.window.movefocus, "l")
hl.bind(mod .. " + Right", hl.dsp.window.movefocus, "r")
hl.bind(mod .. " + Up", hl.dsp.window.movefocus, "u")
hl.bind(mod .. " + Down", hl.dsp.window.movefocus, "d")
hl.bind(mod .. " + Shift + Left", hl.dsp.window.swapwindow, "l")
hl.bind(mod .. " + Shift + Right", hl.dsp.window.swapwindow, "r")
hl.bind(mod .. " + Shift + Up", hl.dsp.window.swapwindow, "u")
hl.bind(mod .. " + Shift + Down", hl.dsp.window.swapwindow, "d")
hl.bind(mod .. " + 1", hl.dsp.workspace, 1)
hl.bind(mod .. " + 2", hl.dsp.workspace, 2)
hl.bind(mod .. " + 3", hl.dsp.workspace, 3)
hl.bind(mod .. " + 4", hl.dsp.workspace, 4)
hl.bind(mod .. " + 5", hl.dsp.workspace, 5)
hl.bind(mod .. " + 6", hl.dsp.workspace, 6)
hl.bind(mod .. " + 7", hl.dsp.workspace, 7)
hl.bind(mod .. " + 8", hl.dsp.workspace, 8)
hl.bind(mod .. " + 9", hl.dsp.workspace, 9)
hl.bind(mod .. " + 0", hl.dsp.workspace, 10)
hl.bind(mod .. " + Shift + 1", hl.dsp.window.movetoworkspace, 1)
hl.bind(mod .. " + Shift + 2", hl.dsp.window.movetoworkspace, 2)
hl.bind(mod .. " + Shift + 3", hl.dsp.window.movetoworkspace, 3)
hl.bind(mod .. " + Shift + 4", hl.dsp.window.movetoworkspace, 4)
hl.bind(mod .. " + Shift + 5", hl.dsp.window.movetoworkspace, 5)
hl.bind(mod .. " + Shift + 6", hl.dsp.window.movetoworkspace, 6)
hl.bind(mod .. " + Shift + 7", hl.dsp.window.movetoworkspace, 7)
hl.bind(mod .. " + Shift + 8", hl.dsp.window.movetoworkspace, 8)
hl.bind(mod .. " + Shift + 9", hl.dsp.window.movetoworkspace, 9)
hl.bind(mod .. " + Shift + 0", hl.dsp.window.movetoworkspace, 10)
hl.bind(mod .. " + Shift + W", hl.dsp.exec_cmd("waypaper --random"))

hl.bind(mod .. " + Control + Left", hl.dsp.window.resizeactive, -10, 0)
hl.bind(mod .. " + Control + Right", hl.dsp.window.resizeactive, 10, 0)
hl.bind(mod .. " + Control + Up", hl.dsp.window.resizeactive, 0, -10)
hl.bind(mod .. " + Control + Down", hl.dsp.window.resizeactive, 0, 10)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"))

hl.bind(mod .. " + mouse:272", hl.dsp.window.movewindow, { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resizewindow, { mouse = true })

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

          workspace = [
            "1, default:true"
            "2"
            "3"
            "4"
            "5"
            "6"
            "7"
            "8"
            "9"
            "10"
          ];