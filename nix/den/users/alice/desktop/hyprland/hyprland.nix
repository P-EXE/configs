{ den, lib, inputs, ... }: {
  flake-file = {
    inputs = {
      awww.url = "git+https://codeberg.org/LGFae/awww";
    };
  };
  den.aspects.alice.desktop.hyprland = {
    includes = [
      den.aspects.alice.theme.archive
    ];
    homeManager = { host, pkgs, ... }: {
        wayland.windowManager.hyprland = {
          enable = true;
				  # set the flake package
          package = null; # inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          portalPackage = null; # inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
          systemd.enable = false;
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
              '') host.monitors
            )}";
            #"workspaceRules" = lib.mkIf (lib.length host.monitors > 0 && (lib.lists.head host.monitors) ? name) ''
            #  hl.workspace_rule({ workspace = "1", monitor = "${(lib.lists.head host.monitors).name}", default = true})
            #'';
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
        services.hypridle = {
          enable = true;
          settings = {
            general = {
              after_sleep_cmd = "hyprctl dispatch dpms on";
              ignore_dbus_inhibit = false;
              lock_cmd = "hyprlock";
            };
            listener = [
              {
                on-timeout = "hyprlock";
                timeout = 900;
              }
              {
                on-resume = "hyprctl dispatch dpms on";
                on-timeout = "hyprctl dispatch dpms off";
                timeout = 1200;
              }
            ];
          };
        };
        services.awww = {
          enable = true;
          package = pkgs.awww; #inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww;
          extraArgs = [ ];
        };
        services.udiskie.enable = true;
        programs = {
          waybar.enable = true;
          tofi.enable = true;
          hyprshot = {
            enable = true;
            saveLocation = "$HOME/Pictures/Screenshots";
          };
        };
        home.packages = [
          #pkgs.wallutils
          pkgs.brightnessctl
          pkgs.waypaper
        ];
      };
  };
}
