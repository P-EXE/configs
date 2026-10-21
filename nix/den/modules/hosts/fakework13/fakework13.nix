{
  den,
  lib,
  __findFile,
  ...
}:
{
  den.hosts.fakework13 = {
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
  den.aspects.fakework13 = {
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
    ++ lib.attrValues den.aspects.fakework13._;

    _.configuration.nixos = { config, pkgs, ... }: {
      nix.settings.experimental-features = [ "nix-command flakes" ];

      services.gvfs.enable = true;
      services.udisks2.enable = true;

      # Checkra1n
      environment.systemPackages = with pkgs; [
        libimobiledevice
        ifuse
      ];
      services.usbmuxd = {
        enable = true;
        package = pkgs.usbmuxd2;
      };

      # PlatformIO
      services.udev.packages = with pkgs; [
        platformio-core.udev
        openocd
        stlink # Needed for ST-Link
      ];

      # Biometrics
      services.fprintd = {
        enable = true;
        tod = {
          enable = false;
          driver = pkgs.libfprint-2-tod1-goodix; # Goodix driver module
        };
      };

      # Use the systemd-boot EFI boot loader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # Use latest kernel.
      boot.kernelPackages = pkgs.linuxPackages_latest;

      #networking.hostName = "nixos"; # Define your hostname.
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

      # Enable networking
      networking.networkmanager.enable = true;

      # Set your time zone.
      time.timeZone = "Europe/Vienna";

      # Select internationalisation properties.
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

      # Enable the GNOME Desktop Environment.
      services.displayManager.gdm.enable = false;
      services.desktopManager.gnome.enable = false;

      # Configure keymap in X11
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };

      # Enable CUPS to print documents.
      services.printing.enable = true;

      # Enable sound with pipewire.
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        jack.enable = true;
        # Use the WirePlumber session manager
        wireplumber.enable = true;
      };

      # Enable touchpad support (enabled default in most desktopManager).
      # services.libinput.enable = true;

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users."alice" = {
        isNormalUser = true;
        description = "alice";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        packages = with pkgs; [
          #  thunderbird
        ];
      };

      # Install firefox.
      programs.firefox.enable = true;

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile.
      # You can use https://search.nixos.org/ to find more packages (and options).
      # environment.systemPackages = with pkgs; [
      #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #   wget
      # ];

      # Some programs need SUID wrappers, can be configured further or are
      # started in user sessions.
      # programs.mtr.enable = true;
      # programs.gnupg.agent = {
      #   enable = true;
      #   enableSSHSupport = true;
      # };

      # List services that you want to enable:

      # Enable the OpenSSH daemon.
      # services.openssh.enable = true;

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      # networking.firewall.enable = false;

      # Copy the NixOS configuration file and link it from the resulting system
      # (/run/current-system/configuration.nix). This is useful in case you
      # accidentally delete configuration.nix.
      # system.copySystemConfiguration = true;

      # This option defines the first version of NixOS you have installed on this particular machine,
      # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
      #
      # Most users should NEVER change this value after the initial install, for any reason,
      # even if you've upgraded your system to a new NixOS release.
      #
      # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
      # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
      # to actually do that.
      #
      # This value being lower than the current NixOS release does NOT mean your system is
      # out of date, out of support, or vulnerable.
      #
      # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
      # and migrated your data accordingly.
      #
      # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
      system.stateVersion = "26.05"; # Did you read the comment?

    };
    _.hardwareConfiguration.nixos =
      {
        config,
        lib,
        pkgs,
        modulesPath,
        ...
      }:
      {
        imports = [
          (modulesPath + "/installer/scan/not-detected.nix")
        ];

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

        fileSystems."/" = {
          device = "/dev/disk/by-uuid/9796a2e5-3939-4796-b25f-99d207a20fd2";
          fsType = "btrfs";
        };

        fileSystems."/home" = {
          device = "/dev/disk/by-uuid/9796a2e5-3939-4796-b25f-99d207a20fd2";
          fsType = "btrfs";
          options = [ "subvol=home" ];
        };

        fileSystems."/nix" = {
          device = "/dev/disk/by-uuid/9796a2e5-3939-4796-b25f-99d207a20fd2";
          fsType = "btrfs";
          options = [ "subvol=nix" ];
        };

        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/97BD-C7E1";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };

        swapDevices = [ ];

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      };
  };
}
