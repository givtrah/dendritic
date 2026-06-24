{ self, ... }: {
  flake.wrappers.rofi = {
    wlib,
    pkgs,
    lib,
    system,
    ...
  }: {
    # 1. Import the official rofi wrapper module
    imports = [ wlib.wrapperModules.rofi ];
    
    package = pkgs.rofi; 

    # 2. Native Nix ExtraConfig options (No raw text strings needed)
    settings = {
      modi = "drun,run,window";
      icon-theme = "Papirus";
      show-icons = true;
      # Automatically pass down your custom wrapped Kitty executable path
      terminal = "${lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.kitty}"; 
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      sidebar-mode = true;
    };

    # 3. Native RASI theme translation (No mkLiteral functions required!)
    theme = {
      "@import" = "~/.cache/wal/colors-rofi-dark.rasi";

      "*" = {
        font = "Inter 12";
        background-color = "transparent";
      };

      "window" = {
        width = "600px";
        height = "400px";
        border = "1px";
        border-color = "@foreground";
        border-radius = "2px";
        background-color = "@background";
      };

      "mainbox" = {
        padding = "32px";
        children = [ "inputbar" "listview" ];
      };

      "inputbar" = {
        margin = "5px";
        padding = "8px";
        border-radius = "2px";
        background-color = "rgba(255, 255, 255, 0.05)";
        children = [ "prompt" "entry" ];
      };

      "prompt" = {
        text-color = "@foreground";
        padding = "0px 10px 0px 0px";
      };

      "entry" = {
        text-color = "@foreground";
        placeholder = "....";
      };

      "listview" = {
        margin = "10px 0px 0px 0px";
        columns = 1;
        lines = 10;
        fixed-height = false;
      };

      "element" = {
        padding = "8px";
        border-radius = "2px";
      };

      "element selected" = {
        background-color = "@color1";
        text-color = "@background";
      };

      "element-icon" = {
        size = "24px";
        margin = "0px 12px 0px 0px";
      };

      "element-text" = {
        vertical-align = "0.5";
        text-color = "inherit";
      };
    };
  };
}
