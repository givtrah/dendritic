{
  inputs,
  self,
  ...
}: {
  # 1. Register the host directly into flake outputs during the file sweep
  flake.nixosConfigurations.taude = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit self inputs; };
    modules = [
      self.nixosModules.hostTaude
    ];
  };

  # 2. Define the host configuration module
  flake.nixosModules.hostTaude = {
    pkgs,
    config,
    lib,
    ...
  }: {
    imports = [
      # Pull Disko safely from inputs or fallback to fetchTarball
      (inputs.disko.nixosModules.disko or "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix")

      # Local Hardware & Device-Specific Subsystems
      self.nixosModules.hardwareTaude
      self.nixosModules.diskoTaude

      # Mango git
      # inputs.mangowm.nixosModules.mango

      # Nixos dendritic modules (exposed by importTree)
      self.nixosModules.all
      self.nixosModules.uwsm
      self.nixosModules.work
    ];

    # Boot Management
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Kernel version
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Kernel options and modules
    # Enable KVM / virtualization and dvd/bluray drives (sg)
    boot.kernelModules = [ "kvm-amd" "kvm-intel" "sg" ]; 

    # Ensure NFS can be mounted at boot / load NFS modules
    boot.supportedFilesystems = [ "nfs" ];

    # Networking & Bluetooth
    networking.hostName = "taude";                                                               
    networking.networkmanager.enable = true;  
    networking.networkmanager.wifi.powersave = false; 

    networking.firewall.enable = false;

    hardware.bluetooth.enable = true;                                 
    hardware.bluetooth.powerOnBoot = true;   

    # Essential services (ssh & ratbagd)                                                                                                              
    services.openssh.enable = true;   
    services.ratbagd.enable = true; 

    # PRINTING
    services.printing.enable = true;                                                                  
    services.ipp-usb.enable = true;                                                                    
    services.avahi = {                                                                            
      enable = true;                                                                                
      nssmdns4 = true;                                                                              
      openFirewall = true;                                                                          
    };                             

    # Mount additional drives

    system.stateVersion = "25.11"; 
  };
}
