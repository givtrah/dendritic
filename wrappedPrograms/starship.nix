{ self, ... }: {

  # 1. Your Custom Wrapped Starship ("starfish")
  flake.wrappers.starship = { wlib, pkgs, ... }: {
    imports = [ wlib.wrapperModules.starship ];
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
      lua.disabled = true;
      python.disabled = true;
      golang.disabled = true;
      rlang.disabled = true;
      rust.disabled = true;
    };
  };
}
