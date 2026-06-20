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

    # 2. Concatenate your raw text configuration files into the module's config text stream
    extraConfig = ''
      # assembled automatically via wrappedPrograms/mango
      
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
