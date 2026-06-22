{ config, lib, pkgs, self, ... }:

{
  imports = [
    # Local Hardware & Device-Specific Subsystems
    ./hardware-configuration.nix
    ./disko-config.nix
    
    # Remote Flake Modules (Disko fetch directly or via inputs)
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"

    # nixos dendritic modules (exposed by import-tree)
    self.nixosModules.all
    self.nixosModules.uwsm
    self.nixosModules.work

  ];

  # Boot Management
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel version
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
