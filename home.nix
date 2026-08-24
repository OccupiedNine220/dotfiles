{ config, pkgs, inputs, lib, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./kitty.nix
    ./fastfetch.nix
    ./mpv.nix
    ./zed.nix
    inputs.spicetify-nix.homeManagerModules.default
    inputs.caelestia-shell.homeManagerModules.default
    inputs.nixcord.homeModules.nixcord
  ];

  programs.caelestia = {
    enable = true;
    systemd.enable = false;
    settings = {
      bar.statusIcons = [
        { id = "lockStatus"; enabled = true; }
        { id = "network"; enabled = true; }
        { id = "bluetooth"; enabled = false; }
        { id = "battery"; enabled = false; }
      ];
      paths.wallpaperDir = "~/Wallpapers";
    };
    cli = {
      enable = true;
      settings.theme.enableGtk = false;
    };
  };

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.text;
    colorScheme = "TokyoNight";
    enabledExtensions = with spicePkgs.extensions; [
    adblock
    hidePodcasts
    ];
  };

  # Discord Canary + Equicord + OpenAsar, управляется через Nixcord
  programs.nixcord = {
    enable = true;
    discord.enable = true;
    discord.equicord.enable = true;
    discord.openASAR.enable = true;
    discord.branch = "canary";
  };


  home.stateVersion = "26.05";

  sops.defaultSopsFile = ./secrets/jellyfin.yaml;
  sops.age.keyFile = "/home/occupiednine220/.config/sops/age/keys.txt";

  programs.fzf.enable = true;
  programs.zoxide.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "history-substring-search"
	"aliases"
        "github"
	"kitty"
      ];
      theme = "agnoster";
     };
    shellAliases = {
      g = "git";
      nixr = "sudo nixos-rebuild switch";
      nv = "nvim";
      snv = "sudo nvim";
      amn = "sudo AmneziaVPN-service";
      s = "sudo";
      fetch = "fastfetch";
      py = "python";
      pi = "echo 3,14159265359";
      c = "clear";
      bt = "btop";
      grok = "(( RANDOM % 2 == 0 )) && echo 'This is true' || echo 'This is not true'";
    };
  };


  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Kirill";
	email = "occupiednine@proton.me";
      };
      alias = {
        c = "commit";
        co = "checkout";
        s = "status";
        ps = "push";
        pl = "pull";
        f = "fetch";
      };
      init.defaultBranch = "main";
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "macOS";
      package = pkgs.apple-cursor;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs."tokyonight-gtk-theme";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];

    config = {
      common = {
        default = [ "gtk" ];
      };
    };
   };

  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    style.name = "kvantum";
  };

    home.file.".config/Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=Kvantum-Tokyo-Night
    '';

  home.packages = with pkgs; [
    protontricks
    librewolf
    neovim
    htop
    btop
    kitty
    xdg-utils
    grim
    slurp
    steam
    throne
    prismlauncher
    element-desktop
    pamixer
    playerctl
    cliphist
    wl-clipboard
    brightnessctl
    jq
    curl
    gh
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    (monocraft.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        find $out/share/fonts -type f ! -name '*nerd-fonts-patched*' -delete
      '';
    }))
    noto-fonts
    obsidian
    helvetica-neue-lt-std
    kdePackages.ark
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    awww
    ffmpeg-full
    yt-dlp
    pear-desktop
    material-icons
    microsoft-edge
    amnezia-vpn
    flameshot
    wf-recorder
    gimp
    gradle
    jetbrains-toolbox
    obs-studio
    google-chrome
    inkscape
    aegisub
    hyfetch
    ncdu
    wine
    blockbench
    chatterino7
    thunderbird
    nemo-with-extensions
    nemo-preview
    nemo-emblems
    nemo-fileroller
    qbittorrent
    socat
    black
    prettier
    rust-analyzer
    gamemode
    spotube
    krita
    unrar
    fluffychat
    easyeffects
    jdk25
    sl
    affine
    ollama-cuda
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
    google-fonts
    mangohud
    feishin
  ] ++ [
    inputs.herdr.packages.${pkgs.system}.default
  ];
}
