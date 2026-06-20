{
  flake.wrappers.git = {
    wlib,
    pkgs,
    ...
  }: {
    imports = [wlib.modules.default];
    package = pkgs.git;
    env = {
      GIT_AUTHOR_NAME = "givtrah";
      GIT_AUTHOR_EMAIL = "givtrah@givtrah.org";
      GIT_COMMITTER_NAME = "givtrah";
      GIT_COMMITTER_EMAIL = "givtrah@givtrah.org";
    };
  };
}
