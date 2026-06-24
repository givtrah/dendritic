{ inputs, self, ... }: {
  # This wraps the system-layer configuration into a safe flake-parts module
  flake.nixosModules.mango = { pkgs, config, ... }: {
    imports = [
      inputs.mangowm.nixosModules.mango
    ];

    config = {
      # Enable the official system-layer compositor service
      programs.mango = {
        enable = true;
      };

      # Inject your custom wrapped variant into the system profile cleanly
      environment.systemPackages = [
        (self.packages.${pkgs.stdenv.hostPlatform.system}.mango.wrap { 
          hostName = config.networking.hostName; 
        })
      ];
    };
  };
}
