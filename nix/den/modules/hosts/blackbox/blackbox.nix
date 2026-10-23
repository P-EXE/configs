{ den, lib, __findFile, ... }:
{
  den.hosts.blackbox = {
    system = "x86_64-linux";
    users.alice = { };
  };
  den.aspects.blackbox.includes = [
  ] ++ lib.attrValues den.aspects.blackbox._;
  den.aspects.blackbox.geist = {
    includes = [
      #<coding>
      #<virtualization>
      #<desktop/gnome>
    ];
    nixos = { config, pkgs, ... }: {
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

      # Connectivity
      # Printing
      services.printing.enable = true;
      # SSH
      services.openssh.enable = true;
      
      # Audio
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };

      # Nix & NixOS
      nixpkgs.config.allowUnfree = true;
      programs.nix-ld.enable = true;

      # Blockdevices
      services.gvfs.enable = true;
      services.udisks2.enable = true;
    };
  };
  den.aspects.blackbox.gestalt = {
    nixos = { config, lib, pkgs, modulesPath, ... }: {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];
      # IO
      # Keyboard
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };
      # Touchpad (Optional, most DEs have it enabled automatically)
      # services.libinput.enable = true;

      # Connectivity
      # Networking
      networking.networkmanager.enable = true;
      networking.firewall.enable = false;
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      #networking.proxy.default = "http://user:password@proxy:port/";
      #networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
      boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;

      # Nix & NixOS
      system.stateVersion = "26.05";
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      # Kernel
      boot.kernelPackages = pkgs.linuxPackages_latest;
      boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      # Bootloader
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # CPU
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      # Blockdevices
      fileSystems = {
        "/" = { 
	  device = "/dev/disk/by-uuid/286c05e4-d4c1-48d7-8fd3-be9781c3ee5a";
      	  fsType = "btrfs";
    	};
        "/home" = { 
	  device = "/dev/disk/by-uuid/286c05e4-d4c1-48d7-8fd3-be9781c3ee5a";
      	  fsType = "btrfs";
          options = [ "subvol=home" ];
    	};
        "/nix" = { 
	  device = "/dev/disk/by-uuid/286c05e4-d4c1-48d7-8fd3-be9781c3ee5a";
      	  fsType = "btrfs";
          options = [ "subvol=nix" ];
    	};
	"/boot" = {
	  device = "/dev/disk/by-uuid/AEB8-9842";
      	  fsType = "vfat";
      	  options = [ "fmask=0077" "dmask=0077" ];
    	};
      };
      swapDevices = [ ];
    };
  };
}
