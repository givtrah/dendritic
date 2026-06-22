# all wrapped programs in a module 
{ self, ... }: {
  
  # Register directly into your framework's module tree
  flake.nixosModules.wrapped = { config, pkgs, ... }: {
    
    environment.systemPackages = [
      # Evaluate your custom shell wrappers
      (self.wrappers.bash.wrap { })
      (self.wrappers.starship.wrap { })
      (self.wrappers.git { })
      (self.wrappers.kitty { })
      (self.wrappers.nvim { })
      (self.wrappers.rofi { })

      # Evaluate MangoWM with the running host context parameters
      (self.wrappers.mango.wrap { hostName = config.networking.hostName; })

      # Same for waybar
      (self.wrappers.waybar.wrap { hostName = config.networking.hostName; })





    ];

  };
}

