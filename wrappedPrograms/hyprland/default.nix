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

      # Inject dependencies and local runtime script derivations here!
      runtimePkgs = [ 
        pkgs.adwaita-icon-theme 
        pkgs.hyprpolkitagent
	pkgs.hyprland
	pkgs.hyprshutdown
        # Evaluates the scripts passing down the current module pkgs context
        (import ./scripts/_wall-random.nix { inherit pkgs; wallpaperDir = ./../../wallpapers; })
        (import ./scripts/_waybar-reload.nix { inherit pkgs; })
      ];

      constructFiles = {
        
        core = {
          relPath = "hyprland/core.lua";
          content = builtins.readFile ./core.lua;
        };
        
        keybindings = {
          relPath = "hyprland/keybindings.lua";
          content = builtins.readFile ./keybindings.lua;
        };
        
        autostart = {
          relPath = "hyprland/autostart.lua";
          content = builtins.readFile ./autostart.lua;
        };

        windows = {
          relPath = "hyprland/windows.lua";
          content = builtins.readFile ./windows.lua;
        };

        monitors = {
          relPath = "hyprland/monitors.lua";
          content = 
            if builtins.pathExists (./. + "/monitors-${config.hostName}.lua") 
            then builtins.readFile (./. + "/monitors-${config.hostName}.lua")
            else ''
              -- ==========================================
              -- FALLBACK DEFAULT MONITOR CONFIGURATION
              -- ==========================================
              -- Auto-detect any connected display at preferred resolution and scaling
              hl.monitor({ name = "", resolution = "preferred", position = "auto", scale = "auto" })

              -- Set up basic un-anchored persistent workspaces 1-5
              for i = 1, 5 do
                hl.workspace_rule({ workspace = tostring(i), persistent = true })
              end
            '';
        };

        # Main Entry Point
        main = {
          relPath = "hyprland/hyprland.lua";
          content = ''
            -- Instruct Lua's packager to search the relative wrapper output layout directory
            package.path = package.path .. ";" .. "${dirOf config.constructFiles.main.path}/?.lua"

            -- Load modules in sequential order
            require("monitors")
            require("core")
            require("windows")
            require("keybindings")
            require("autostart")
          '';
        };
      };

      # Tell the Hyprland binary to launch targeting the main file path
      flags."--config" = config.constructFiles.main.path;
    };
  };
}
