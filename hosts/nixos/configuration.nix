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
    kitty rofi wl-clipboard neovim kdePackages.dolphin
    zip unzip
    gcc bun ripgrep fd go just
    python3 uv
    home-manager
  ];

  networking.hostName = hostname;
  system.stateVersion = stateVersion;
}
