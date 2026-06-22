{ self, ... }: {
  flake.wrappers.mango = {
    wlib,
    pkgs,
    lib,
    config,
    ...
  }: {
    # Import the official upstream mangowc wrapper module
    imports = [ wlib.wrapperModules.mangowc ];

    # Set the underlying compositor binary layer to the mango github nix flake
    package = inputs.mangowm.packages.${pkgs.stdenv.hostPlatform.system}.default; 

    # required packages
    extraPackages = [ 
      pkgs.adwaita-icon-theme 

      # Import and evaluate scripts, passing the module's pkgs context down
      (import ./scripts/wall-random.nix { inherit pkgs; })
      (import ./scripts/waybar-reload.nix { inherit pkgs; })
    ];

    # Concatenate raw text configuration files into the module's config text stream
    extraConfig = ''
      # assembled automatically via wrappedPrograms/mango

      # First include default colors (may be overwritten later by importing pywal16 colors)
      ${builtins.readFile ./theme-colors-default.conf}

      # Main config (everything not below)
      ${builtins.readFile ./config.conf}

      # Monitor layouts (see below how to call mango)
      ${builtins.readFile (./ + "/monitors-${config.hostName}.conf")}

      # Core Keybindings & Shortcuts
      ${builtins.readFile ./keybindings.conf}

      # Theme, Borders, Visuals & Gaps
      ${builtins.readFile ./theme.conf}

      # Window Layouts & Management Rules
      ${builtins.readFile ./layouts.conf}

      # Environment Autostart Routines
      ${builtins.readFile ./autostart.conf}
    '';
  };
}

# should be called as the following in order to include hostname
# environment.systemPackages = [
#  (self.packages.${pkgs.system}.mango.wrap { 
#    hostName = config.networking.hostName; 
#  })
# ];
