{
  description = "AmZaDin14's Personal System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    ashell.url = "github:MalpenZibo/ashell";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs"; };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, catppuccin,
              ashell, nvf, ... }@inputs: let
      system = "x86_64-linux";
      homeStateVersion = "25.05";
      user = "amri";
      hosts = [
        { hostname = "nixos"; stateVersion = "25.05"; }
      ];

      makeSystem = { hostname, stateVersion }: nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = { inherit inputs stateVersion hostname user; };
        modules = [ ./hosts/${hostname}/configuration.nix catppuccin.nixosModules.catppuccin ];
      };
    in {
      nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
        configs // {
          "${host.hostname}" = makeSystem { inherit (host) hostname stateVersion; };
        }) {} hosts;

      homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit inputs homeStateVersion user; };
        modules = [ ./home-manager/home.nix catppuccin.homeModules.catppuccin nvf.homeManagerModules.default ];
      };
  };
}
