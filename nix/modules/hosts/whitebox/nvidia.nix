{
  den,
  inputs,
  ...
}:
{
  den.aspects.whitebox._.nvidia = {
    nixos =
      { config, ... }:
      let
        pkgs = import inputs.nixpkgs {
          config.allowUnfree = true;
          config.cudaSupport = true;
          config.cudaVersion = "12";
        };
      in
      {
        environment.packages = with pkgs; [
          cudatoolkit
          cudaPackages.cudnn
        ];
        services.xserver.videoDrivers = [ "nvidia" ];
        hardware.nvidia = {
          modesetting.enable = true;
          powerManagement.enable = false;
          powerManagement.finegrained = false;
          open = false;
          nvidiaSettings = true;
          package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
        };
        nix.settings = {
          substituters = [
            "https://cache.nixos-cuda.org"
          ];
          trusted-public-keys = [
            "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
          ];
        };
      };
  };
}
