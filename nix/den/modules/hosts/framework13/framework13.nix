{
  den,
  lib,
  __findFile,
  ...
}:
{
  den.hosts.framework13 = {
    system = "x86_64-linux";
    users.alice = { };
    # TODO: This is apparently freeform, although a schema for this existsm, map how?
    hasDesktop = true;
    monitors = [
      {
        name = "eDP-1";
        resolution.x = 2880;
        resolution.y = 1920;
        refreshRate = 120;
        position.x = 0;
        position.y = 1;
        safeZones.tl.x = 0;
        safeZones.tl.y = 0;
        safeZones.tr.x = 0;
        safeZones.tr.y = 0;
        safeZones.br.x = 0;
        safeZones.br.y = 0;
        safeZones.bl.x = 0;
        safeZones.bl.y = 0;
        scale = 1.0;
        pseudoScale = 2.0;
        colorSpace = "srgb";
      }
    ];
  };
  den.aspects.framework13 = {
    includes = [
      <displayManager/tuigreet>
      <desktop/hyprland>
      <virtualization>
      (den.lib.policy.when
        (
          { user, ... }:
          lib.hasAttrByPath [ user.name "gui" ] den.aspects
        )
        (
          den.lib.policy.mkPolicy "gui-package-user" (
            { user, ... }: [
              (den.lib.policy.include [
                den.aspects.${user.name}.gui
              ])
            ]
          )
        )
      )
    ]
    ++ lib.attrValues den.aspects.framework13._;
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

        # Audio
        services.pulseaudio.enable = false;
        security.rtkit.enable = true;
        services.pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          jack.enable = true;
          wireplumber.enable = true;
        };

        # Connectivity
        # Networking
        networking.networkmanager.enable = true;
        networking.firewall.enable = false;
        # networking.firewall.allowedTCPPorts = [ ... ];
        # networking.firewall.allowedUDPPorts = [ ... ];
        #networking.proxy.default = "http://user:password@proxy:port/";
        #networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
        programs.wireshark = {
          enable = true;
          package = pkgs.wireshark-cli;
          dumpcap.enable = true;
          usbmon.enable = true;
        };
        boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;
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
        # (20261020) Added because:
        # Refusing to evaluate package 'zfs-kernel-2.4.4-7.3' because it has problems:
        # - broken: This package is broken
        nixpkgs.config = {
          problems.handlers = {
            zfs.broken = "warn"; # or "ignore"
          };
        };
        boot.supportedFilesystems.zfs = lib.mkForce false;

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
        boot.zfs.forceImportRoot = false; # It is highly recommended to set it to `false`, the new default from 26.11 on, to reduce the risk of data loss. Alternatively, you can silence this warning by explicitly setting it to `true`.

        # Architecture
        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

        # Filesystem
        services.gvfs.enable = true;
        services.udisks2.enable = true;
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
