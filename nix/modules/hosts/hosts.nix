# defines all hosts + users + homes.
# then config their aspects in as many files you want
{
  # tux user at igloo host.
  den.hosts.x86_64-linux.silverslab = rec {
    users.alice = {
      wallpaperPath = "~/Pictures/Wallpapers/Clay Banks/Arizona/Wheat.jpg";
    };
    displays = [
      {
        name = "eDP-1";
        id = 0;
        friendlyName = "BOE NE135A1M-NY1";
        resolution.x = 2880;
        resolution.y = 1920;
        size.x = 290;
        size.y = 190;
        dpi = 256;
        refreshRate = 120;
        scale = 1;
        pseudoScale = 1.5;
        safeZones = {
          tl.x = 24;
          tl.y = 24;
          tr.x = 24;
          tr.y = 24;
          br.x = 12;
          br.y = 12;
          bl.x = 12;
          bl.y = 12;
        };
        position.x = 0;
        position.y = 0;
      }
    ];
    primaryDisplay = builtins.elemAt displays 0;
    battery = {
    };
  };
  den.hosts.x86_64-linux.whitebox = rec {
    users.alice = {
      wallpaperPath = "~/Pictures/Wallpapers/Clay Banks/Arizona/Wheat.jpg";
    };
    displays = [
      {
        name = "DP-5";
        id = 1;
        friendlyName = "LC49HG90DMRXEN";
        resolution.x = 3840;
        resolution.y = 1080;
        size.x = 1200;
        size.y = 340;
        dpi = 82;
        refreshRate = 144;
        scale = 1;
        pseudoScale = 1;
        safeZones = {
          tl.x = 8;
          tl.y = 8;
          tr.x = 8;
          tr.y = 8;
          br.x = 8;
          br.y = 8;
          bl.x = 8;
          bl.y = 8;
        };
        position.x = 0;
        position.y = 0;
      }
      {
        name = "HDMI-A-2";
        id = 0;
        friendlyName = "AOC 2460";
        resolution.x = 1920;
        resolution.y = 1080;
        size.x = 530;
        size.y = 300;
        dpi = 82;
        refreshRate = 60;
        scale = 1;
        pseudoScale = 1;
        safeZones = {
          tl.x = 8;
          tl.y = 8;
          tr.x = 8;
          tr.y = 8;
          br.x = 8;
          br.y = 8;
          bl.x = 8;
          bl.y = 8;
        };
        position.x = 3840;
        position.y = 0;
      }
    ];
    primaryDisplay = builtins.elemAt displays 0;
    battery = {
    };
  };

  # define an standalone home-manager for tux
  # den.homes.x86_64-linux.alice = { };

  # be sure to add nix-darwin input for this:
  # den.hosts.aarch64-darwin.apple.users.alice = { };

  # other hosts can also have user tux.
  # den.hosts.x86_64-linux.south = {
  #   wsl = { }; # add nixos-wsl input for this.
  #   users.tux = { };
  #   users.orca = { };
  # };
}
