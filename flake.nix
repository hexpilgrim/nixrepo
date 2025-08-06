# flake.nix
{
  description = "Personal Nix Package Registry";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true;
      };

      packageDirs = builtins.filter (name:
        builtins.pathExists (./pkgs + "/${name}/default.nix")
      ) (builtins.attrNames (builtins.readDir ./pkgs));

      allPackages = builtins.listToAttrs (
        map (name: {
          name = name;
          value = pkgs.callPackage (./pkgs + "/${name}/default.nix") {};
        }) packageDirs
      );
    in {
      packages.${system} = allPackages;
    };
}
