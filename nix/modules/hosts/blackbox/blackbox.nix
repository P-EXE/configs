{ den, lib, ... }: {
  # host aspect
  den.aspects.blackbox = {
    includes = with den.aspects.blackbox; [
      hardware
      firmware
      software
      ssh
    ];

    nixos = {
      users.users.admin.initialHashedPassword = "admin";
    };

    _.hardware.nixos =
      {
        lib,
        config,
        pkgs,
        modulesPath,
        ...
      }:
      {
        imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
        fileSystems = {
          "/" = {
            device = "/dev/disk/by-uuid/dba8260e-a03f-4e77-a570-b56f29723849";
            fsType = "btrfs";
            options = [ "subvol=@" ];
          };
          "/home" = {
            device = "/dev/disk/by-uuid/dba8260e-a03f-4e77-a570-b56f29723849";
            fsType = "btrfs";
            options = [ "subvol=@home" ];
          };
          "/boot" = {
            device = "/dev/disk/by-uuid/DBE0-9B50";
            fsType = "vfat";
            options = [
              "fmask=0077"
              "dmask=0077"
            ];
          };
          #"/mnt/storage" = {
          #  device = "/dev/pool/lvraid1";
          #  fsType = "btrfs";
          #};
        };
        swapDevices = [ ];
        # Keyboard
        services.xserver.xkb = {
          layout = "us";
          variant = "";
        };
      };

    _.firmware.nixos =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      {
        # Boot
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;
        # Kernel
        boot.kernelPackages = pkgs.linuxPackages_latest;
        boot.initrd.availableKernelModules = [
          "xhci_pci"
          "ahci"
          "usbhid"
          "usb_storage"
          "sd_mod"
        ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [
          "kvm-intel"
          "dm-raid"
        ];
        boot.extraModulePackages = [ ];
        # CPU
        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
        # Disks
        boot.swraid.enable = true;
        #GPU
        hardware.graphics.enable = true;
        services.xserver.videoDrivers = [ "nvidia" ];
        hardware.nvidia = {
          modesetting.enable = true;
          powerManagement.enable = false;
          powerManagement.finegrained = false;
          open = false;
          nvidiaSettings = true;
          package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
        };
        # Network
        networking = {
          hostName = "Blackbox";
          firewall = {
            enable = false;
            allowedTCPPorts = [ ];
            allowedUDPPorts = [ ];
          };
        };
      };

    _.software.nixos = {
      # Network
      networking.networkmanager.enable = true;
      # Printing
      services.printing.enable = true;
      # Locale
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
      # Nix
      nixpkgs.config.allowUnfree = true;
      programs.nix-ld.enable = true;
      nix.settings = {
        trusted-users = [ "@wheel" ];
        builders-use-substitutes = true;
        experimental-features = [ "nix-command flakes" ];
      };
      system.stateVersion = "25.11";
    };
  };
}
