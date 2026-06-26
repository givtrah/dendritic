{ self, ... }: {
  
  flake.nixosModules.wrapped = { config, pkgs, ... }: {
    
    environment.systemPackages = [
      # 1. Host-dependent wrappers that need custom arguments
      (self.wrappers.mango.wrap { inherit pkgs; hostName = config.networking.hostName; })
      (self.wrappers.hyprland.wrap { inherit pkgs; hostName = config.networking.hostName; })      
      (self.wrappers.waybar.wrap { inherit pkgs; hostName = config.networking.hostName; })

      # 2. Cleanly evaluate all standard wrappers by mapping over a list
    ] ++ (map (name: self.wrappers.${name}.wrap { inherit pkgs; }) [
      "starship"
      "git"
      "kitty"
      "neovim"
      "rofi"
      "swaylock"
      "swayidle"
    ]);

  };
}
