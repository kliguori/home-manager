{
  description = "Home manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
  let
    mkHome = { system, username, hostname }: 
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ 
          ./modules
        ];
        extraSpecialArgs = { 
          inherit inputs hostname username;
        };
      };
  in
  {
    homeConfigurations = {
      # Sherlock - Desktop with 2 monitors
      "kevin@sherlock" = mkHome {
        system = "x86_64-linux";
        username = "kevin";
        hostname = "sherlock";
      };
      
      # Watson - Laptop with single monitor
      "kevin@watson" = mkHome {
        system = "x86_64-linux";
        username = "kevin";
        hostname = "watson";
      };
    };
  };
}
