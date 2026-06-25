{
  inputs,
  self,
  ...
}: {
  # 1. Register the host directly into flake outputs during the file sweep
  flake.nixosConfigurations.taupa = inputs.nixpkgs.lib.nixosSystem {
    # If this specific host needs an architecture other than x86_64-linux (e.g. Asahi Mac), change it here
    system = "x86_64-linux";
    specialArgs = { inherit self inputs; };
    modules = [
      self.nixosModules.hostTaupa
    ];
  };

  # 2. Define the host configuration module
  flake.nixosModules.hostTaupa = {
    pkgs,
    config,
    lib,
    ...
  }: {
    imports = [
      # Pull Disko from inputs or fallback to fetchTarball if not in inputs
      (inputs.disko.nixosModules.disko or "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix")

      self.nixosModules.hardwareTaupa
      self.nixosModules.diskoTaupa


      self.nixosModules.wrapped

      # Nixos dendritic modules (exposed by importTree)
      self.nixosModules.all
      self.nixosModules.swayidle
      self.nixosModules.uwsm
      self.nixosModules.work
    ];

    # Boot Management
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Kernel version
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Kernel options and modules
    boot.kernelModules = [ "kvm-amd" "kvm-intel" ];    

    # Load NFS modules / enable NFS access at boot
    boot.supportedFilesystems = [ "nfs" ];

    # Networking & Bluetooth
    networking.hostName = "taupa";                                                               
    networking.networkmanager.enable = true;  
    networking.networkmanager.wifi.powersave = false; 

    networking.firewall.enable = false;

    hardware.bluetooth.enable = true;                                 
    hardware.bluetooth.powerOnBoot = true;   

    # Essential services (ssh)                                                                                                              
    services.openssh.enable = true;   

    # PRINTING
    services.printing.enable = true;                                                                  
    services.printing.drivers = with pkgs; [ gutenprint canon-cups-ufr2 ];                            
    services.printing.logLevel = "debug";                                                             
    services.ipp-usb.enable = true;                                                                    
    services.avahi = {                                                                            
      enable = true;                                                                                
      nssmdns4 = true;                                                                              
      openFirewall = true;                                                                          
    };                             

    # Mount additional drives
    fileSystems."/mnt/vm" = {                                                                       
      device = "/dev/disk/by-uuid/a6928e70-7552-4a8b-83cc-2834259c3e35";                                                                         
      fsType = "btrfs";                                                                                
      options = [ 
        "noatime" 
        "compress=zstd:3" 
        "users" 
        "nofail" 
      ];                                                                                              
    };

    system.stateVersion = "25.11"; 
  };
}
