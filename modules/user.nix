{ pkgs, user, ...}: {
  users = {
    defaultUserShell = pkgs.nushell;
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}
