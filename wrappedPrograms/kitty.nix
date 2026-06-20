{ self, ... }: {
  flake.wrappers.kitty = {
    wlib,
    pkgs,
    lib,
    ...
  }: let
    font_family = "JetBrainsMono NF";
  in {
    # 1. Import the native kitty wrapper module schema
    imports = [ wlib.wrapperModules.kitty ];

    # 2. Tell the wrapper what engine or binary layer to configure
    package = pkgs.kitty;

    # 3. Handle Font overrides directly (ensures the paths exist in the store)
    font = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = font_family;
      size = 12;
    };

    # 4. Map your standard configuration matrix
    settings = {
      bold_font = "${font_family} Bold";
      italic_font = "${font_family} Italic";
      bold_italic_font = "${font_family} Bold Italic";

      disable_ligatures = "cursor";
      copy_on_select = true;

      # fuck sounds
      enable_audio_bell = false;
      window_alert_on_bell = false;
      bell_on_tab = false;

      window_margin_width = 0;
      background_opacity = 0.9;
      adjust_line_height = "130%";

      # Window layout
      hide_window_decorations = "titlebar-only";
      window_padding_width = "10";

      # Tab bar
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_title_template = "Tab {index}: {title}";
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";
      tab_activity_symbol = "";

      allow_remote_control = "socket-only";
      listen_on = "unix:/tmp/kitty";
    };

    # 5. Handle keybindings explicitly mapping them to kitty syntax
    keybindings = {
      "kitty_mod+s" = "paste_from_clipboard";
      "kitty_mod+v" = "paste_from_selection";
      "alt+shift+enter" = "clone-in-kitty --type=os-window";
    };

    # 6. Drop manual string flags or local modifications here
    extraConfig = ''
      modify_font underline_position 2
      modify_font underline_thickness 200%

      modify_font cell_width 100%
      modify_font cell_height -1px
    '';
  };
}
