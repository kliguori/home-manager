{
  description = "Home manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
  let
    mkHome = { system, username, hostname }: 
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ 
          ./home.nix
        ];
        extraSpecialArgs = { 
          inherit inputs hostname username system;
        };
      };
  in
  {
    homeConfigurations = {
      "macbook" = mkHome {
        system = "aarch64-darwin";
        username = "kevinliguori";
        hostname = "macbook";
      };
      
      "sherlock" = mkHome {
        system = "x86_64-linux";
        username = "kevin";
        hostname = "sherlock";
      };
      
      "watson" = mkHome {
        system = "x86_64-linux";
        username = "kevin";
        hostname = "watson";
      };
    };
  };
}
