hl.on("hyprland.start", function ()
  hl.exec_cmd("systemctl --user enable --now hyprpolkitagent.service")
  hl.exec_cmd("udiskie & waybar & blueman-applet")
end)