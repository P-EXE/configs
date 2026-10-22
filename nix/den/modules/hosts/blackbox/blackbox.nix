{ den, lib, __findFile, ... }:
{
  den.hosts.blackbox = {
    system = "x86_64-linux";
    users.alice = { };
  };
  den.aspects.blackbox.includes = [
  ] ++ lib.attrValues den.aspects.blackbox._;
  den.aspects.blackbox.software = {
    includes = [
      <coding>
      <virtualization>
      <desktop/gnome>
    ];
    nixos = {
      # Blockdevices
      services.gvfs.enable = true;
      services.udisks2.enable = true;

      # Nix & NixOS
      nixpkgs.config.allowUnfree = true;
      programs.nix-ld.enable = true;
    };
  };
  den.aspects.blackbox.firmware.nixos = { pkgs, ... }: {
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

    # IO
    # Keyboard
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
    # Touchpad (Optional, most DEs have it enabled automatically)
    # services.libinput.enable = true;
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

    # Connectivity
    # Networking
    networking.networkmanager.enable = true;
    networking.firewall.enable = false;
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    #networking.proxy.default = "http://user:password@proxy:port/";
    #networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;
    # Printing
    services.printing.enable = true;
    # SSH
    services.openssh.enable = true;

    # Nix & NixOS
    system.stateVersion = "26.05";

    # Kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.initrd.availableKernelModules = [ "sd_mod" "sr_mod" ];
		boot.initrd.kernelModules = [ ];
		boot.kernelModules = [ ];
		boot.extraModulePackages = [ ];

    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
  den.aspects.blackbox.hardware.nixos = {
    boot.supportedFilesystems.zfs = lib.mkForce false;
    fileSystems = {
			"/" = { 
				device = "/dev/disk/by-uuid/113f5886-46c0-48eb-8f79-4d77ae39ebf2";
      	fsType = "ext4";
    	};
			"/boot" = {
				device = "/dev/disk/by-uuid/3D68-D745";
      	fsType = "vfat";
      	options = [ "fmask=0077" "dmask=0077" ];
    	};
		};
    swapDevices = [ ];

  	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
