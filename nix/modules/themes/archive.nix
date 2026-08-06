{ den, inputs, ... }: {
  flake-file = {
    inputs.hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };
  den.aspects.themes._.archive = { host, ... }: let
		appColors = {
			color0 = "#000000";
			color1 = "#202020";
    	color2 = "#FF6188";
    	color3 = "#A9DC76";
    	color4 = "#FFD866";
    	color5 = "#2386D1";
    	color6 = "#AB9DF2";
    	color7 = "#78DCE8";
    	color8 = "#E6E6E6";
			color9 = "#FFFFFF";
    	color10 = "#CC768C";
    	color11 = "#92A87D";
    	color12 = "#CCB87A";
    	color13 = "#3A739E";
    	color14 = "#A7A3BF";
    	color15 = "#82B0B5";
		};
		uiColors = {
			color0 = "#000000";
			color1 = "#202020";
    	color2 = "#404040";
    	color3 = "#A0A0A0";
    	color4 = "#E6E6E6";
    	color5 = "#FFFFFF";
    	color6 = "#FF4F00";
    	color7 = "#FF0000";
    	color8 = "#FF0000";
			color9 = "#FF0000";
    	color10 = "#FF0000";
    	color11 = "#FF0000";
    	color12 = "#FF0000";
    	color13 = "#FF0000";
    	color14 = "#FF0000";
    	color15 = "#FF0000";
		};
    uiFont = "JetBrainsMono NF";
	in {
		# !TODO Is this really needed?
		#homeManager = {
		#	fonts.fontconfig.enable = true;
		#};
		homeManager = { pkgs, ... }: {
      wayland.windowManager.hyprland.plugins = [
        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
      ];
      wayland.windowManager.hyprland = {
        extraLuaFiles = {
          "theme" = ''
            hl.config({
              general = {
                layout = "dwindle"
                border_size = 0
                gaps_in = 0
                gaps_out = 0
              }
            })
          '';
        };
		  };
      programs.tofi.settings = {
    	  width = "100%";
    	  height = "100%";
    	  border-width = 0;
    	  outline-width = 0;
    	  padding-left = 32;
    	  padding-top = 0;
    	  result-spacing = builtins.floor (-64 * host.primaryDisplay.pseudoScale);
    	  num-results = 0;
    	  font = uiFont + " Medium";
    	  #font-variations = "wght 100";
    	  #font-features = "ss08 on";
    	  font-size = "${builtins.toString (128 * host.primaryDisplay.pseudoScale)}px";
    	  text-color = uiColors.color1;
    	  background-color = uiColors.color0;
    	  selection-color = uiColors.color4;
    	  selection-match-color = uiColors.color6;
    	  selection-background-padding = "16px 0 16px 16px";
    	  prompt-text = "↘";
  	  };
      programs.waybar = {
        settings.mainBar = {
			    layer = "bottom";
          position = "top";
          modules-left = [ "hyprland/workspaces" "wlr/taskbar" ];
          modules-center = [ "custom/media" ];
          modules-right = [ "tray" "hyprland/language" "bluetooth" "network" "cpu" "memory" "temperature" "backlight" "wireplumber#source" "wireplumber#sink" (if host.battery != null then "battery" else "") "clock" ];
          #output = [];
          "hyprland/workspaces" = {};
          "wlr/taskbar" = {
            format = "{icon}";
            icon-size = (12 * host.primaryDisplay.pseudoScale);
            tooltip-format = "{title}";
            on-click = "activate";
            on-click-middle = "close";
            rotate = 0;
          };
          "custom/media" = {
            format = "{icon} {text}";
            return-type = "json";
            max-length = 40;
            format-icons = {
              spotify = "";
              default = "🎜";
            };
            escape = true;
            exec = "$HOME/mediaplayer.py 2> /dev/null"; #Script in resources folder
            #exec = "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" // Filter player based on name
          };
          "tray" = {
            icon-size = 10;
            spacing = 8;
            rotate = 0;
          };
          "hyprland/language" = {
            format = "{}";
            format-de = "DE";
            format-en = "US";
            rotate = 0;
          };
          "bluetooth" = {
            #"controller" = "controller1";
            format-on = " On";
            format-off = " Off";
            format-disabled = " Disabled";
            format-connected = " {num_connections}";
            tooltip-format = "{controller_alias}\t{controller_address}";
            tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
            #"tooltip-format-connected" = "{device_enumerate}";
            tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
            on-click = "hyprctl dispatch -- exec kitty -e bluetuith";
          };
          "network" = {
            format-ethernet = "{icon} {ipaddr}/{cidr}";
            format-wifi = "{icon} {essid}";
            format-disconnected = "No Network ⚠";
		  	  	format-linked = "{icon} {ifname} (No IP)";
            format-icons = ["░" "▂" "▄" "▆" "█"];
            tooltip-format = "if: {ifname}\nip: {ipaddr}/{cidr}/{cidr6}\ngw: {gwaddr}";
            tooltip-format-wifi = "if: {ifname}\nip: {ipaddr}/{cidr}/{cidr6}\ngw: {gwaddr}\nstr: {signalStrength}\nstr dB: {signaldBm}\nfreq: {frequency} GHz\nup: {bandwidthUpBits}\ndown: {bandwidthDownBits}";
            on-click = "hyprctl dispatch -- exec kitty -e impala";
            rotate = 0;
          };
          "cpu" = {
            format = " {usage}%";
            on-click = "hyprctl dispatch -- exec kitty -e btop";
            rotate = 0;
          };
          "memory" = {
            format = " {}%";
            on-click = "hyprctl dispatch -- exec kitty -e btop";
            rotate = 0;
          };
			    "temperature" = {
            #thermal-zone = 2;
            #hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
            critical-threshold = 80;
            #format-critical = "{icon} {temperatureC}°C";
            format = "{icon} {temperatureC}°C";
            format-icons = ["󰉬" "" "󰉪"];
    	    };
          #"wireplumber" = {
          # format = "SPKR: {volume}%-{node_name}";
          #  format-muted = "SPKR: Muted-{node_name}";
          #  on-click = "";
          #  format-icons = ["◂" "◄" "◀"];
          #  rotate = 0;
          #};
          "backlight" = {
            format = "{icon} {percent}%";
            format-icons = [ "󰃞" "󰃟" "󰃠" ];
          };
          "wireplumber#sink" = {
            format = "{icon} {volume}%";
            format-muted = "{icon} X";
            format-icons = ["" "" ""];
            on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            on-click-right = "helvum";
            scroll-step = 5;
          };
          "wireplumber#source" = {
            node-type = "Audio/Source";
            format = "{icon} {volume}%";
            format-muted = "{icon} X";
            format-icons = ["" "" ""];
            on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
            scroll-step = 5;
          };
          "pulseaudio" = {
            scroll-step = 1;
            format = "Vol: {volume}%";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = "{volume}% ";
            format-source-muted = " ";
            format-icons = {
              "headphone" = " ";
              "hands-free" = " ";
              "headset" = " ";
              "phone" = " ";
              "portable" = " ";
              "car" = " ";
              "default" = ["" " " " "];
            };
            on-click = "pavucontrol";
            rotate = 0;
          };
          "battery" = {
            states = {
                #good = 90;
                warning = 30;
                critical = 15;
            };
            format = "{icon} {capacity}%";
            format-full = "{icon} {capacity}%";
            format-charging = "{icon} {capacity}%";
            format-plugged = "{icon} {capacity}%";
            format-alt = "{icon} {time}";
            #format-good = "";
            #format-full = "";
            format-icons = ["" "" "" "" ""];
    	    };
          "clock" = {
            format = "{:L%A %d.%m.%Y(W%V) %H:%M:%S (%z)}";
            rotate = 0;
          };
          "custom/waybar-mpris" = {
            "return-type"= "json";
            "exec" = "waybar-mpris --position --autofocus";
            "on-click" = "waybar-mpris --send toggle";
            # This option will switch between players on right click.
            "on-click-right" = "waybar-mpris --send player-next";
            # The options below will switch the selected player on scroll
            # "on-scroll-up" = "waybar-mpris --send player-next";
            # "on-scroll-down" = "waybar-mpris --send player-prev";
            # The options below will go to next/previous track on scroll
            #"on-scroll-up" = "waybar-mpris --send next";
            #"on-scroll-down" = "waybar-mpris --send prev";
            "escape" = true;
            rotate = 0;
          };
        };
        style = ''
          * {
            all: unset;
            font-family: '${uiFont}';
          }
      
          window#waybar>box {
            background: #000000;
            font-size: ${toString(10 * host.primaryDisplay.pseudoScale)}px;
            padding: ${toString (2 * host.primaryDisplay.pseudoScale)}px ${toString host.primaryDisplay.safeZones.tl.x}px;
          }
      
          tooltip {
            background: transparent;
            /* border: 1px solid rgba(100, 114, 125, 0.5); */
          }
          tooltip label {
            background: ${uiColors.color0};
            margin: 4px;
          }
      
          #workspaces {
          }
          #workspaces button {
            padding: ${toString (4 * host.primaryDisplay.pseudoScale)}px;
            color: ${uiColors.color5};
            font-family: '${uiFont} ExtraBold';
          }
          #workspaces button.active {
            color: ${uiColors.color6};
            font-family: '${uiFont}';
          }
          #taskbar {
            padding: ${toString (2 * host.primaryDisplay.pseudoScale)}px;
          }
          #taskbar * {
            padding: ${toString (1 * host.primaryDisplay.pseudoScale)}px;
          }
      
          #tray {
            padding: ${toString (1 * host.primaryDisplay.pseudoScale)}px;
          }
          #language {
            padding: 0px ${toString (8 * host.primaryDisplay.pseudoScale)}px 0px 0px;
          }
          #bluetooth {
            padding: 0px ${toString (12 * host.primaryDisplay.pseudoScale)}px 0px 0px;
            /* color: #ff6188; */
          }
          #network {
            padding: 0px ${toString (14 * host.primaryDisplay.pseudoScale)}px 0px 0px;
            /* color: #fc9867; */
          }
          #cpu {
            padding: 0px ${toString (6 * host.primaryDisplay.pseudoScale)}px 0px 0px;
            /* color: #ffd866; */
          }
          #memory {
            padding: 0px ${toString (6 * host.primaryDisplay.pseudoScale)}px 0px 0px;
            /* color: #ffd866; */
          }
          #temperature {
            padding: 0px ${toString (12 * host.primaryDisplay.pseudoScale)}px 0px 0px;
            /* color: #ffd866; */
          }
          #backlight {
            padding: 0px ${toString (10 * host.primaryDisplay.pseudoScale)}px 0px 0px;
            /* color: #ffd866; */
          }
          #wireplumber.source {
            padding: 0px ${toString (4 * host.primaryDisplay.pseudoScale)}px 0px 0px;
            /* color: #a9dc76; */
          }
          #wireplumber.sink {
            padding: 0px ${toString (10 * host.primaryDisplay.pseudoScale)}px 0px 0px;
            /* color: #a9dc76; */
          }
          #battery {
            padding: 0px ${toString (12 * host.primaryDisplay.pseudoScale)}px 0px 0px;
            /* color: #78dce8; */
          }
          #clock {
            padding: 0px;
            /* color: #ab9df2; */
          }
        '';
      };
      programs.kitty = {
		    enable = true;
		    settings = {
		      font_size = builtins.toString (8 * host.primaryDisplay.pseudoScale);
		      font_family = uiFont + " Regular";
		      cursor_shape = "beam";
		      cursor_shape_unfocused = "unchanged";
		      window_padding_width = 0;
		      background = appColors.color0;
		      foreground = appColors.color8;
		      cursor = appColors.color9;
		      selection_background = appColors.color8;
		      selection_foreground = appColors.color0;
		      color0 = "";
		      color1 = appColors.color2;
		      color2 = appColors.color3;
		      color3 = appColors.color4;
		      color4 = appColors.color5;
		      color5 = appColors.color6;
		      color6 = appColors.color7;
		      color7 = "";
		      color8 = "";
		      color9 = appColors.color10;
		      color10 = appColors.color11;
		      color11 = appColors.color12;
		      color12 = appColors.color13;
		      color13 = appColors.color14;
		      color14 = appColors.color15;
		      color15 = "";
		    };
	    };
		};

    nixos = {
      services.displayManager.ly = {
        settings = {
          battery_id = "BAT0";
          bigclock = "English";
        };
      };
    };

		provides.to-hosts.nixos = { pkgs, ... }: {
			fonts.packages = with pkgs; [
  			nerd-fonts.jetbrains-mono
			];
		};
  };
}