{ den, lib, inputs, ... }: {
  den.aspects.whitebox = {
    includes = [
      den.aspects.desktops.hyprland
      den.aspects.virtualization
      den.aspects.winapps
    ] ++ lib.attrValues den.aspects.whitebox._;

    _.hardware.nixos = { lib, config, pkgs, modulesPath,  ... }: {
      imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
      # Blockdevices
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/f1b01f89-eb95-4ada-a3c4-2353e60f837f";
          fsType = "btrfs";
        };
        "/home" = {
          device = "/dev/disk/by-uuid/f1b01f89-eb95-4ada-a3c4-2353e60f837f";
          fsType = "btrfs";
          options = [ "subvol=home" ];
        };
        "/nix" = {
          device = "/dev/disk/by-uuid/f1b01f89-eb95-4ada-a3c4-2353e60f837f";
          fsType = "btrfs";
          options = [ "subvol=nix" ];
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/1104-C602";
          fsType = "vfat";
          options = [ "fmask=0077" "dmask=0077" ];
        };
      };
      swapDevices = [ ];
      # Connectivity
      hardware.bluetooth.enable = true;
      services.blueman.enable = true;
      # Keyboard
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };
      # Audio
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
      };
    };
    _.firmware.nixos = { pkgs, lib, config, ... }: {
      boot.loader.systemd-boot.enable = true;
      boot.loader.systemd-boot.configurationLimit = 5;
      boot.loader.efi.canTouchEfiVariables = true;

      boot.kernelPackages = pkgs.linuxPackages_latest;
      boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.blacklistedKernelModules = [ ];
      boot.extraModulePackages = [ ];
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      boot.extraModprobeConfig = ''
        options hid_apple fnmode=2
      '';
      # Added: "options hid_apple fnmode=2" to /etc/modprobe.d/hid_apple.conf

      services.gvfs.enable = true;
      services.udisks2.enable = true;

      hardware.graphics.enable = true;
      hardware.graphics.enable32Bit = true;
      services.xserver.enable = true;
      environment.sessionVariables = {
        NO_HARDWARE_CURSORS = 1;
      };

      networking = {
        hostName = "Whitebox";
        firewall = {
          enable = true;
          allowedTCPPorts = [ ];
          allowedUDPPorts = [ ];
        };
      };
    };
    _.software.nixos = { pkgs, config, ... }: {
      services.desktopManager.plasma6.enable = true;
      services.displayManager.sddm = { 
        enable = false;
        wayland.enable = true;
      };
      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${inputs.tuigreet.packages.${pkgs.stdenv.hostPlatform.system}.tuigreet}/bin/tuigreet --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --remember --remember-user-session";
            user = "greeter";
          };
        };
      };

      networking.networkmanager.enable = true;
      networking.wireless.iwd.enable = false;

      services.printing.enable = true;

      time.timeZone = "Europe/Vienna";
      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "de_AT.UTF-8";
        LC_IDENTIFICATION = "de_AT.UTF-8";
        LC_MEASUREMENT = "de_AT.UTF-8";
        LC_MONETARY = "de_AT.UTF-8";
        LC_NAME = "de_AT.UTF-8";
        LC_NUMERIC = "de_AT.UTF-8";
        LC_PAPER = "de_AT.UTF-8";
        LC_TELEPHONE = "de_AT.UTF-8";
        LC_TIME = "de_AT.UTF-8";
      };

      nixpkgs.config.allowUnfree = true;
      programs.nix-ld.enable = true;
      nix.settings = {
        trusted-users = [ "@wheel" ];
        builders-use-substitutes = true;
        experimental-features = [ "nix-command flakes" ];
        # !TODO Remove after finding a way to add it to the hyprland aspect
        substituters = ["https://hyprland.cachix.org"];
        trusted-substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
      };
      system.stateVersion = "26.05";
    };
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        hello
      ];
    };
    provides.to-users.homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [ 
        # Gaming
        prismlauncher
      ];
    };
  };
}
