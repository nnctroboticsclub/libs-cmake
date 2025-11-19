{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system} = {
        cmake-libs = pkgs.callPackage ./cmake-libs { };
        gcc-arm-toolchain = pkgs.callPackage ./gcc-arm-toolchain { };
      };
    };
}
