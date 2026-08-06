local mod = "SUPER"
hl.config({
  input = {
    kb_layout = "us";
    kb_options = "grp:alt_space_toggle";
    repeat_rate = 25;
    repeat_delay = 300;
  },
})

hl.bind(mod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mod .. " + DELETE", hl.dsp.exec_cmd("hyprshutdown"))
hl.bind(mod .. " + SHIFT + DELETE", hl.dsp.exec_cmd("systemctl shutdown -h now"))
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd("pkill tofi-drun || tofi-drun | xargs hyprctl dispatch exec --"))
hl.bind(mod .. " + SHIFT + SPACE", hl.dsp.exec_cmd("pkill tofi-run || tofi-run | xargs hyprctl dispatch exec --"))
hl.bind(mod .. " + K", hl.dsp.exec_cmd("kitty"))
hl.bind(mod .. " + E", hl.dsp.exec_cmd("kitty yazi"))
hl.bind("CONTROL_L + SHIFT_L + ESCAPE", hl.dsp.exec_cmd("kitty btop"))
hl.bind(mod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m output --clipboard-only"))
hl.bind(mod .. " + SHIFT + CONTROL + PRINT", hl.dsp.exec_cmd("hyprshot -m window --clipboard-only"))
hl.bind(mod .. " + EQUAL", hl.dsp.exec_cmd("hyprctl keyword monitor \"eDP-1, preferred, auto, 1.5\""))
hl.bind(mod .. " + MINUS", hl.dsp.exec_cmd("hyprctl keyword monitor \"eDP-1, preferred, auto, 1\""))

-- Windows
  -- Focus
    hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }))
    hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
    hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }))
    hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }))
  -- Swap
    hl.bind(mod .. " + SHIFT + LEFT", hl.dsp.window.swap({ direction = "left" }))
    hl.bind(mod .. " + SHIFT + RIGHT", hl.dsp.window.swap({ direction = "right" }))
    hl.bind(mod .. " + SHIFT + UP", hl.dsp.window.swap({ direction = "up" }))
    hl.bind(mod .. " + SHIFT + DOWN", hl.dsp.window.swap({ direction = "down" }))
  -- Move & Resize
    hl.bind(mod .. " + CONTROL + LEFT", hl.dsp.window.resize({x = -10, y = 0}))
    hl.bind(mod .. " + CONTROL + RIGHT", hl.dsp.window.resize({x = 10, y = 0}))
    hl.bind(mod .. " + CONTROL + UP", hl.dsp.window.resize({x = 0, y = -10}))
    hl.bind(mod .. " + CONTROL + DOWN", hl.dsp.window.resize({x = 0, y = 10}))
    hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
    hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
  -- State
    hl.bind(mod .. " + RETURN", hl.dsp.window.fullscreen())
    hl.bind(mod .. " + W", hl.dsp.window.float())

hl.bind(mod .. " + SHIFT + W", hl.dsp.exec_cmd("waypaper --random"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"))

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

-- Workspaces
  -- Switch
    for i = 1, 10 do
      local key = i % 10 -- 10 maps to key 0
      hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i}))
      hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    end
    hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
    hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
