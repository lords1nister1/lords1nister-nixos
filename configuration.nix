{ config, pkgs, ... }:

#

{
   imports = [
    ./hardware-configuration.nix
  ];
    
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "user" ];
      substituters = [ "https://cache.nixos.org" ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;
  

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.ensureProfiles.profiles = {
  home-wifi = {
    connection = {
      id = "ARRIS-022C";
      type = "wifi";
      autoconnect = true;
    };
    wifi = {
      ssid = "ARRIS-022C";
      mode = "infrastructure";
    };
    wifi-security = {
      key-mgmt = "wpa-psk";
      psk = "C420252B5187245B";
    };
    ipv4.method = "auto";
    ipv6.method = "auto";
  };
  other-wifi = {
    connection = {
      id = "HUAWEI-E5180-28D7";
      type = "wifi";
      autoconnect = true;
    };
    wifi = {
      ssid = "HUAWEI-E5180-28D7";
      mode = "infrastructure";
    };
    wifi-security = {
      key-mgmt = "wpa-psk";
      psk = "949N31LEHH8";
    };
    ipv4.method = "auto";
   ipv6.method = "auto";
  };


  };

  time.timeZone = "Europe/Vienna";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  services.desktopManager.plasma6.enable = true;
  services.flatpak.enable = true;
  boot.blacklistedKernelModules = [ "pcspkr" ];
  systemd.services.NetworkManager-wait-online.enable = false;

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  services.xserver = {
   enable = true;
   displayManager.sddm.enable = true;
   windowManager.i3.enable = true;
   desktopManager.xterm.enable = false;
   displayManager.defaultSession = "none+i3";
  };

  console.keyMap = "de";
  services.upower.enable = true;
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.logind.settings.Login.HandlePowerKey = "poweroff";
  

  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "networkmanager" "wheel" "input"];
    
  };
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.appimage.package = pkgs.appimage-run.override {
    extraPkgs = pkgs: [ pkgs.ffmpeg pkgs.imagemagick ];
  }
  ;


  programs.light.enable = true;
  programs.nix-index-database.comma.enable = true;
  programs.firefox.enable = true;
  environment.systemPackages = [
    
    pkgs.kitty
    pkgs.brave
    pkgs.fastfetch
    pkgs.fzf
    pkgs.cava
    pkgs.gnome-secrets
    pkgs.neofetch
    pkgs.clock-rs
    pkgs.btop
    pkgs.htop
    pkgs.pipes
    pkgs.pipes-rs
    pkgs.asciiquarium-transparent
    pkgs.eza
    pkgs.lm_sensors
    pkgs.spotube
    pkgs.tree
    pkgs.python313Packages.cmake
    pkgs.vim
    pkgs.nix-search-cli
    pkgs.iotop
    pkgs.bat
    pkgs.sl
    pkgs.superfile
    pkgs.git
    pkgs.gimp
    pkgs.nixd
    pkgs.rustc
    pkgs.cargo
    pkgs.pkg-config
    pkgs.ncurses
    pkgs.peaclock
    pkgs.s-tui
    pkgs.vlc
    pkgs.dmenu
    pkgs.brightnessctl
    pkgs.pavucontrol
    pkgs.pulseaudio
    pkgs.flameshot
    pkgs.picom
    pkgs.i3status
    pkgs.networkmanagerapplet
    pkgs.dunst
    pkgs.pamixer
    pkgs.libnotify
    pkgs.playerctl
    pkgs.libinput-gestures
    pkgs.libxcvt.out
    pkgs.feh
    pkgs.xclip
    pkgs.rofi
    pkgs.arandr
    pkgs.cool-retro-term
    pkgs.appimage-run
    pkgs.jq
    pkgs.tenki
    pkgs.gping

#
#

  ];


  system.stateVersion = "25.11";
}
