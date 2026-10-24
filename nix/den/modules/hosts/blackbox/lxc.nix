{ den, ... }: {
  den.hosts.blackbox-lxc = {
    system = "x86_64-linux";
    users.alice = { };
    users.bob = { };
  };
  den.aspects.blackbox-lxc = {
    includes = [
      den.aspects.blackbox.geist
    ];
    nixos = { config, modulesPath, pkgs, lib, ... }: {
      imports = [ (modulesPath + "/virtualisation/proxmox-lxc.nix") ];
      nix.settings = {
        sandbox = false; 
      };  
      proxmoxLXC = {
        manageNetwork = false;
        privileged = true;
      };
      services.fstrim.enable = false; # Let Proxmox host handle fstrim
      services.openssh = {
        enable = true;
        openFirewall = true;
        settings = {
          PermitRootLogin = "yes";
          PasswordAuthentication = true;
          PermitEmptyPasswords = "yes";
        };
      };
      system.stateVersion = "26.05";
      #nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    };
  };
}
