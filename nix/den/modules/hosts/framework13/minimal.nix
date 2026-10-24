{
  den,
  lib,
  __findFile,
  ...
}:
{
  den.hosts.framework13-minimal = {
    system = "x86_64-linux";
    users.blank = { };
  };
  den.aspects.framework13-minimal = {
    includes = [
    ];

    nixos =
      {
        config,
        pkgs,
        modulesPath,
        ...
      }:
      {
        imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

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

        # Device
        # Keyboard
        services.xserver.xkb = {
          layout = "us";
          variant = "";
        };
        # Touchpad (enabled default in most desktopManager).
        #services.libinput.enable = true;
        # Biometrics
        services.fprintd = {
          enable = true;
          tod = {
            enable = false;
            driver = pkgs.libfprint-2-tod1-goodix; # Goodix driver module
          };
        };
        # Display
        environment.systemPackages = with pkgs; [
          brightnessctl
        ];

        # Connectivity
        # Networking
        networking.networkmanager.enable = true;
        networking.firewall.enable = false;
        # networking.firewall.allowedTCPPorts = [ ... ];
        # networking.firewall.allowedUDPPorts = [ ... ];
        #networking.proxy.default = "http://user:password@proxy:port/";
        #networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
        #boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;
        # Bluetooth
        hardware.bluetooth = {
          enable = true;
          powerOnBoot = false;
        };
        services.blueman.enable = true;
        # Printing
        services.printing.enable = true;

        # Nix
        system.stateVersion = "26.05";
        nix.settings.experimental-features = [ "nix-command flakes" ];

        # Kernel
        boot.kernelPackages = pkgs.linuxPackages_latest;
        boot.initrd.availableKernelModules = [
          "nvme"
          "xhci_pci"
          "thunderbolt"
          "usb_storage"
          "sd_mod"
        ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-amd" ];
        boot.extraModulePackages = [ ];

        # Bootloader
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        # Platform
        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

        # Filesystem
        fileSystems = {
          "/" = {
            device = "/dev/disk/by-uuid/9796a2e5-3939-4796-b25f-99d207a20fd2";
            fsType = "btrfs";
          };
          "/home" = {
            device = "/dev/disk/by-uuid/9796a2e5-3939-4796-b25f-99d207a20fd2";
            fsType = "btrfs";
            options = [ "subvol=home" ];
          };
          "/nix" = {
            device = "/dev/disk/by-uuid/9796a2e5-3939-4796-b25f-99d207a20fd2";
            fsType = "btrfs";
            options = [ "subvol=nix" ];
          };
          "/boot" = {
            device = "/dev/disk/by-uuid/97BD-C7E1";
            fsType = "vfat";
            options = [
              "fmask=0077"
              "dmask=0077"
            ];
          };
        };
        swapDevices = [ ];
      };
  };
}
