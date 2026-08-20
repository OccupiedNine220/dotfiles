{ config, pkgs, ... }:
let
  jellyfin-script = pkgs.stdenv.mkDerivation {
    pname = "mpv-jellyfin";
    version = "unstable-2026-06-15";

    src = pkgs.fetchFromGitHub {
      owner = "EmperorPenguin18";
      repo = "mpv-jellyfin";
      rev = "main";
      sha256 = "sha256-bC9suv/wuxFk3rhIKMsv6Bwcag9wkWkphh8g32wDlno=";
    };

    installPhase = ''
      mkdir -p $out/share/mpv/scripts
      cp scripts/jellyfin.lua $out/share/mpv/scripts/
    '';

    # Важно для home-manager programs.mpv.scripts
    passthru = {
      scriptName = "jellyfin.lua";
    };
  };

  anime4kShaders = "${pkgs.anime4k}/share/anime4k";
  homeDir = config.home.homeDirectory;
in
{
  home.packages = [ pkgs.anime4k ];

  sops.secrets.jellyfin_password = { };

  sops.templates."jellyfin.conf".content = ''
    url=http://localhost:8096
    username=root
    password=${config.sops.placeholder.jellyfin_password}
    image_path=${homeDir}/.cache/mpv/jellyfin
    use_playlist=on
  '';

  systemd.user.services.mpv-jellyfin-conf-link = {
    Unit = {
      Description = "Symlink rendered jellyfin.conf into mpv script-opts";
      After = [ "sops-nix.service" ];
      Wants = [ "sops-nix.service" ];
    };

    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.coreutils}/bin/ln -sf ${config.sops.templates."jellyfin.conf".path} ${homeDir}/.config/mpv/script-opts/jellyfin.conf";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  programs.mpv = {
    enable = true;

    scripts = with pkgs.mpvScripts; [
      mpv-discord
      uosc
      thumbfast
      sponsorblock
      jellyfin-script
    ];

    config = {
      profile = "gpu-hq";
      vo = "gpu-next";
      hwdec = "nvdec";
      hwdec-codecs = "all";
      gpu-api = "vulkan";
      gpu-context = "waylandvk";

      sub-color = "#ebdbb2";
      sub-border-color = "#282828";
      osd-color = "#fabd2f";
      osd-back-color = "#282828";

      audio-display = "no";

      sub-auto = "fuzzy";
      sub-font = "Noto Sans";
      sub-font-size = 45;
      sub-margin-y = 40;

      osd-level = 1;
      osc = "no";
      osd-font-size = 20;
      osd-border-size = 2;

      deinterlace = "auto";
      dither = "fruit";
      temporal-dither = "yes";

      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      dscale = "mitchell";

      cache = "yes";
      demuxer-max-bytes = "500M";
      demuxer-max-back-bytes = "100M";

      save-position-on-quit = "yes";
      watch-later-directory = "${homeDir}/.config/mpv/watch_later";

      screenshot-directory = "${homeDir}/Pictures";
      screenshot-format = "png";
      screenshot-png-compression = 9;

      force-seekable = "yes";

      ytdl-raw-options = "cookies=${homeDir}/boosty-cookies.txt";
    };

    bindings = {
      "menu" = "script-binding uosc/menu";
      "s" = "script-binding uosc/subtitles";
      "a" = "script-binding uosc/audio";
      "v" = "script-binding uosc/video";
      "p" = "script-binding uosc/playlist";
      "c" = "script-binding uosc/chapters";

      "SPACE" = "cycle pause";

      "RIGHT" = "seek 5";
      "LEFT" = "seek -5";

      "UP" = "add volume 2";
      "DOWN" = "add volume -2";

      "WHEEL_UP" = "add volume 2";
      "WHEEL_DOWN" = "add volume -2";
    };

    scriptOpts = {
      uosc = {
        color_foreground = "ebdbb2ff";
        color_background = "282828aa";
        color_accent = "fabd2fff";
        color_primary = "fe8019ff";
        color_highlight = "8ec07cff";

        autohide = "yes";
        autohide_delay = 3;

        border_size = 2;
        title_position = "top";
        font_size = 16;

        proximity_border = 40;
        show_chapters = "yes";
        show_playlist = "yes";
        show_timestamp = "yes";

        mouse_support = "yes";
        proximity_out = "no";
      };
    };

    profiles = {
      anime = {
        glsl-shaders = builtins.concatStringsSep ":" [
          "${anime4kShaders}/Anime4K_Denoise_Bilateral_Mode.glsl"
          "${anime4kShaders}/Anime4K_Deblur_DoG.glsl"
          "${anime4kShaders}/Anime4K_Clamp_Highlights.glsl"
          "${anime4kShaders}/Anime4K_Restore_CNN_M.glsl"
          "${anime4kShaders}/Anime4K_Upscale_CNN_x2_M.glsl"
          "${anime4kShaders}/Anime4K_AutoDownscalePre_x2.glsl"
          "${anime4kShaders}/Anime4K_AutoDownscalePre_x4.glsl"
        ];
      };
    };
  };

  home.activation.createJellyfinCache =
    config.lib.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p ${homeDir}/.cache/mpv/jellyfin
    '';
}
