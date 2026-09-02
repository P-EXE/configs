{ den, lib, ... }: {
  den.aspects.alice._.desktop = {
    includes = lib.attrValues den.aspects.alice.desktop._;
    _.hyprland.homeManager =
      {
        pkgs,
        host,
        lib,
        ...
      }:
      {
        wayland.windowManager.hyprland = {
          settings = {
            mod = {
              _var = "Super";
            };
          };
          extraLuaFiles = {
            "keybinds" = ./keybinds.lua;
            "startup" = ./startup.lua;
            "monitors" = "${builtins.concatStringsSep " " (
              map (m: ''
                hl.monitor({
                  output = "${m.name}",
                  mode = "${toString m.resolution.x}x${toString m.resolution.y}@${toString m.refreshRate}",
                  position = "${toString m.position.x}x${toString m.position.y}",
                  scale = ${toString m.scale},
                })
              '') host.displays
            )}";
            "workspaceRules" = ''
              hl.workspace_rule({ workspace = "1", monitor = "${(builtins.elemAt host.displays 0).name}", default = true})
            '';
          };
        };
        services.dunst = {
          enable = true;
          settings = {
            global = {
              monitor = 0;
              follow = "none";
              width = 300;
              height = 300;
              offset = "30x50";
              origin = "top-right";
              #transparency = 10;
              #frame_color = "#eceff1";
              background = "#000000";
              frame_width = 0;
              font = "JetBrains Mono 9";

              timeout = 1;
            };
          };
        };
        programs = {
          waybar.enable = true;
          tofi.enable = true;
        };
        home.packages = [
          pkgs.hyprshot
        ];
      };
  };
}
