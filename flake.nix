{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "libs-cmake";
        version = "0.1.0";

        src = ./.;

        nativeBuildInputs = [ pkgs.cmake ];
      };
    };
}
