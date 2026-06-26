{ self, ... }: {
  flake.wrappers.hyprlock = {
    wlib,
    pkgs,
    lib,
    ...
  }: {
    # 1. Import the official upstream module wrapper schema from wlib
    imports = [ wlib.wrapperModules.hyprlock ];

    # 2. Bind the underlying base package layer
    package = pkgs.hyprlock;

    # 3. Add runtime packages if you need utilities like fonts/imagery tools
    runtimePkgs = [
      pkgs.noto-fonts
    ];

    # 4. Bind the configuration settings schema
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 0;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          path = "screenshot"; # Captures and blurs your active screen state
          color = "rgba(25, 20, 20, 1.0)";
          blur_passes = 2;
          blur_size = 6;
          brightness = 0.7;
          vibrancy = 0.5;
          noise = 0.4;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          outline_thickness = 3;
          dots_size = 0.33;
          dots_spacing = 0.15;
          dots_center = true;
          outer_color = "rgb(151515)";
          inner_color = "rgb(200, 200, 200)";
          font_color = "rgb(10, 10, 10)";
          fade_on_empty = true;
          placeholder_text = "<i>Password...</i>";
          hide_input = false;
          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          text = "$TIME";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 64;
          font_family = "Noto Sans";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
