{ self, ... }: {
  # Wraps the flatpak setup into a shareable module
  flake.nixosModules.flatpakSetup = { lib, config, pkgs, ... }: {
    services.flatpak.packages = [
      "com.github.IsmaelMartinez.teams_for_linux"
      "com.github.tchx84.Flatseal"
      "org.onlyoffice.desktopeditors"
      "org.libreoffice.LibreOffice"
      "com.valvesoftware.Steam"
      "com.heroicgameslauncher.hgl"
      "org.freedesktop.Platform.VulkanLayer.MangoHud"
    ];
  };
}
