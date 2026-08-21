# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./docker.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  # Nvidia
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  boot.kernelParams = [
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"
  ];
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };
  hardware.nvidia-container-toolkit.enable = true;

  zramSwap = {
    enable = true;
    memoryPercent = 90;
    algorithm = "zstd";
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd start-hyprland";
        user = "greeter";
      };
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  # Set your time zone.
  time.timeZone = "Europe/Kaliningrad";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.zsh.enable = true;
  
  # Define a user account.
  users.users.occupiednine220 = {
    isNormalUser = true;
    description = "Kirill";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  services.system-config-printer.enable = true;
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      epson-escpr2
      epson-escpr
    ];
  };

  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };
  # System packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    fastfetch
    glib
    eza
    bat
    ripgrep
    fd
    mesa-demos
    vulkan-tools
    lm_sensors
    bc
    gcc
    gnumake
    python3
    uv
    pkg-config
    (zed-editor.fhsWithPackages (pkgs: [ pkgs.zlib ]))
  ];


  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {
      cudaSupport = true;
    };
  };

  virtualisation.docker = {
    enable = true;
  };

  programs.nix-ld.enable = true;

  services.gvfs.enable = true;

  services.dbus.enable = true;
  services.netbird.enable = true;
  fileSystems."/mnt/disk1" =
    { device = "/dev/disk/by-uuid/d8619da3-b34b-4391-a7b1-479a0ade0fda";
      fsType = "ext4";
    };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "26.05";

  services.sshd.enable = true;

  networking.firewall.allowedTCPPorts = [ 11434 ];

  programs.kdeconnect.enable = true;

}
