{ config, pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "/home/occupiednine220/power-lines-moon-anime-quite-night-4k-pb-1440x900.jpg"
      ];
      wallpaper = [
        ",/home/occupiednine220/power-lines-moon-anime-quite-night-4k-pb-1440x900.jpg"
      ];
      splash = false;
    };
  };
}
