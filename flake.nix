# flake.nix
{
  description = "Personal Nix Package Registry";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      system = system;
      config = {
        allowUnfree = true;
      };
    };
  in {
    packages.${system}.cursor = pkgs.callPackage ./pkgs/cursor/default.nix {};
  };
}
