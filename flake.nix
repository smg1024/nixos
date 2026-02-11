{
  description = "Kmeat NixOS";

  inputs = {
    # Nix Packages Unstable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NVF for neovim
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nvf,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      hostname = "kmeat-nixos";
      username = "poby";
    in
    {
      nixosConfigurations = {
        ${hostname} = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              system
              inputs
              hostname
              username
              ;
          };
          modules = [ ./configuration.nix ];
          inherit system;
        };
      };

      homeConfigurations = {
        ${username} = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {
            inherit
              system
              inputs
              hostname
              username
              ;
          };
          modules = [
            nvf.homeManagerModules.default
            ./home.nix
          ];
        };
      };
    };
}
