hl.on("hyprland.start", function ()
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("udiskie & waybar & hyprpaper & awww-daemon & blueman-applet")
end)