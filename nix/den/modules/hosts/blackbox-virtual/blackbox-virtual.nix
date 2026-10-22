{ den, lib, __findFile, ... }:
{
  den.hosts.blackbox-virtual = {
    system = "x86_64-linux";
    users.alice = { };
  };
  den.aspects.blackbox-virtual = {
	includes = [
		den.aspects.blackbox.software
		den.aspects.blackbox.firmware
	] ++ lib.attrValues den.aspects.blackbox-virtual._;
	nixos = {
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
  	virtualisation.hypervGuest.enable = true;
	};
  };
}
