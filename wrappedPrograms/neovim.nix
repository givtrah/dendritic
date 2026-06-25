{ self, ... }: {
  flake.wrappers.neovim = {
    wlib,
    pkgs,
    lib,
    ...
  }: {
    # 1. Import the native Neovim wrapper module schema
    imports = [ wlib.wrapperModules.neovim ];

    # 2. Assign the underlying Neovim engine binary
    package = pkgs.neovim-unwrapped;

    # 3. Handle runtime host providers
#    overrides = {
#      withNodeJs = true;
#      withPython3 = true;
#      withRuby = true;
#    };

    # 4. Ingest your raw standalone Lua configuration file

    # extraConfig = builtins.readFile ./nvim-init.lua;
#    initLua = ./nvim-init.lua;
    
    specs.INIT_MAIN.data = builtins.readFile ./nvim-init.lua;


    # 5. Native Luarocks support maps cleanly here
# NOT WORKING, ADDED BELOW    extraLuaPackages = ls: with ls; [ luarocks ];


    # 6. Isolate development packages and Language Servers directly to Neovim's internal PATH
    runtimePkgs = with pkgs; [
      # Language Servers (Look Ma, No Mason!)
      lua-language-server       # Lua
      pyright                   # Python
      rPackages.languageserver  # R
      tinymist                  # Typst

      luarocks

      # Build tools & system dependencies used by plugins (e.g., Telescope, Treesitter compiles)
      doq
      sqlite
      cargo
      clang
      cmake
      gcc
      gnumake
      ninja
      pkg-config
      yarn
    ];
  };
}
