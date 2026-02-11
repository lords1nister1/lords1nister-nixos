
# Rebuild: nixswitch (broken)
# Actually rebuild: cswitch
# 
#


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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

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

  systemd.services.NetworkManager-wait-online.enable = false;
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.flatpak.enable = true;
  services.picom = {
  enable = true;
  backend = "glx";
  fade = true;
  shadow = true;
  settings = {
    opacity-rule = [
      "80:class_g = 'Firefox'"
    ];
  };
};
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  console.keyMap = "de";

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
 

   services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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
  pkgs.gnome-secrets
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
  pkgs.picom
  pkgs.rmpc
  pkgs.git



  ];


  system.stateVersion = "25.11";
}
