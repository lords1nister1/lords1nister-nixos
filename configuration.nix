{ config, pkgs, ... }:

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
  networking.networkmanager.ensureProfiles.profiles = 
  {
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

 ipv4 = {
  method = "auto";
 };

 ipv6 = {
  method = "auto";
  };
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

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.flatpak.enable = true;
  boot.blacklistedKernelModules = [ "pcspkr" ];
  systemd.services.NetworkManager-wait-online.enable = false;

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  console.keyMap = "de";

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;


  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  programs.firefox.enable = false;


  environment.systemPackages = with pkgs; [
    pkgs.kitty
    pkgs.fastfetch
    pkgs.fzf
    pkgs.cava
    ppkgs.gnome-secrets
    pkgs.neofetch
    pkgs.starship
    pkgs.clock-rs
    pkgs.peaclock
    pkgs.btop
    pkgs.htop
    pkgs.pipes
    pkgs.pipes-rs
    pkgs.asciiquarium-transparent
    pkgs.eza
    pkgs.lm_sensors
    pkgs.tree
    pkgs.kde-rounded-corners
    pkgs.python313Packages.cmake
    pkgs.vim
    pkgs.neovim
    pkgs.nix-search-cli
    pkgs.iotop
    pkgs.bat
    pkgs.sl
    pkgs.superfile
  ];


  system.stateVersion = "25.11";
}
