# New fancy dendritic nix
# based on vimjoyer and goxore nixconfigs:
# https://github.com/vimjoyer/nixconf/blob/main/flake.nix
# https://github.com/Goxore/nixconf

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

    # For M$ Surface Laptop 4
    nixos-hardware.url = "github:NixOS/nixos-hardware/master"; 

    # For Macbook Air M2
    apple-silicon = {                                                                               
      url = "github:nix-community/nixos-apple-silicon";                                             
      inputs.nixpkgs.follows = "nixpkgs";                                                           
    };                 

    # Majority of hosts has been setup using disko
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Mango WM - window manager of choice (lightweight, more stable than hyprland)
    mangowm = {                                                                                     
      url = "github:mangowm/mango";                                                                 
      inputs.nixpkgs.follows = "nixpkgs";                                                           
    }; 

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };

    # Framework used to structure the flake, module imports are automatic via custom function below (e.g. no dependency on "import-tree")
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Framework used to wrap packages with home-manager
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

  };


# Import all .nix files from current directory except flake.nix recursively
  outputs = inputs: let
    inherit (inputs.nixpkgs) lib;
    inherit (lib.fileset) toList fileFilter;

    isNixModule = file:
      file.hasExt "nix"
      && file.name != "flake.nix"
      && !lib.hasPrefix "_" file.name;

    importTree = path:
      toList (fileFilter isNixModule path);

    mkFlake = inputs.flake-parts.lib.mkFlake {inherit inputs;};
  in
    mkFlake {imports = importTree ./.;};
}

