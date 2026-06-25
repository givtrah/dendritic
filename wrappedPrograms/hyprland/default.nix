{ inputs, self, ... }: {
  flake.wrappers.hyprland = {
    wlib,
    pkgs,
    lib,
    config,
    ...
  }: {
    imports = [ wlib.modules.default ];

    options = {
      hostName = lib.mkOption {
        type = lib.types.str;
        default = "default";
        description = "Target hostname for loading local monitor/workspace definitions";
      };
    };

    config = {
      package = lib.mkDefault pkgs.hyprland;

      # 1. Compile the sub-config module slices
      constructFiles = {
        
        # Core configuration options (gaps, decoration, layouts)
        "hyprland/core.lua".content = builtins.readFile ./core.lua;
        
        # Keybindings layout
        "hyprland/keybindings.lua".content = builtins.readFile ./keybindings.lua;
        
        # Autostart / initialization loops
        "hyprland/autostart.lua".content = builtins.readFile ./autostart.lua;

        # Host-specific monitors and persistent workspaces mapping
        "hyprland/monitors.lua".content = 
          if builtins.pathExists (./. + "/monitors-${config.hostName}.lua") 
          then builtins.readFile (./. + "/monitors-${config.hostName}.lua")
          else "-- No specific monitor lua config found for ${config.hostName}";

        # 2. Main Entry point: requires the generated sub-files
        # We modify Lua's package.path so it knows to find files in this wrapper store build!
        "hyprland/hyprland.lua".content = ''
          -- Instruct Lua's packager to search the relative wrapper output layout directory
          package.path = package.path .. ";" .. "${config.constructFiles."hyprland/hyprland.lua".dir}/?.lua"

          -- Load modules in sequential order
          require("monitors")
          require("core")
          require("keybindings")
          require("autostart")
        '';
      };

      # 3. Tell Hyprland binary to launch targeting the main file
      flags."--config" = config.constructFiles."hyprland/hyprland.lua".path;
    };
  };
}
