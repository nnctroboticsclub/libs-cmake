{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system} = rec {
        libs-cmake = pkgs.stdenv.mkDerivation {
          pname = "libs-cmake";
          version = "0.1.0";

          src = ./.;

          nativeBuildInputs = [ pkgs.cmake ];
        };
        mbed-os-src = pkgs.stdenv.mkDerivation {
          pname = "mbed-os-src";
          version = "0.1.0";

          src = builtins.fetchGit {
            url = "https://github.com/mbed-ce/mbed-os.git";
            ref = "master";
            rev = "17dc3dc2e6e2817a8bd3df62f38583319f0e4fed";
          };

          installPhase = ''
            cp -r . $out
          '';
        };
        mbed-os = pkgs.stdenv.mkDerivation {
          pname = "mbed-os";
          version = "0.1.0";

          src = ./mbed-os;

          installPhase = ''
            mkdir -p $out/lib/cmake

            cp MbedCE-Toolchain.cmake $out/lib/cmake
            cp MbedCE.cmake $out/lib/cmake

            cat <<EOF > $out/lib/cmake/FindMbedOS.cmake
            set(mbed-os_SOURCE_DIR ${mbed-os-src})

            include(FindPackageHandleStandardArgs)
            find_package_handle_standard_args(mbed-os
              REQUIRED_VARS
                mbed-os_SOURCE_DIR
            )
            EOF
          '';
        };
      };
    };
}
