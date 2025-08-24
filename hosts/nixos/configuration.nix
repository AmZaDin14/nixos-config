{ config, pkgs, stateVersion, hostname, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    ../../modules
    ./hardware-configuration.nix
  ];
  
  services.upower.enable = true;
  environment.systemPackages = with pkgs; [
    kitty rofi wl-clipboard
    zip unzip
    gcc bun ripgrep fd python3 go
    home-manager
  ];

  networking.hostName = hostname;
  system.stateVersion = stateVersion;
}
