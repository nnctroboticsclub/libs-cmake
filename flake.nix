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

          nativeBuildInputs = [
            pkgs.cmake
          ];
          buildInputs = [
            mbed-os
          ];
        };

        gcc-arm-toolchain = pkgs.stdenv.mkDerivation {
          pname = "gcc-arm-toolchain";
          version = "0.1.0";

          src = ./.;

          buildPhase =
            let prefix = "${pkgs.gcc-arm-embedded}/bin/arm-none-eabi";
            in ''
            cat <<EOF > GccArmToolchain.cmake
            set(CMAKE_SYSTEM_NAME Generic)
            set(CMAKE_SYSTEM_PROCESSOR arm)

            set(CMAKE_C_COMPILER "${prefix}-gcc")
            set(CMAKE_CXX_COMPILER "${prefix}-g++")
            set(CMAKE_ASM_COMPILER "${prefix}-gcc")
            set(CMAKE_OBJCOPY "${prefix}-objcopy")
            set(CMAKE_OBJDUMP "${prefix}-objdump")
            set(CMAKE_SIZE "${prefix}-size")
            set_property(GLOBAL PROPERTY ELF2BIN "${prefix}-objcopy")

            set(CMAKE_C_COMPILER_WORKS 1)
            set(CMAKE_CXX_COMPILER_WORKS 1)
            set(CMAKE_ASM_COMPILER_WORKS 1)
            EOF
          '';

          installPhase = ''
            mkdir -p $out/lib/cmake

            cp GccArmToolchain.cmake $out/lib/cmake
          '';
        };

        mbed-os-src = pkgs.stdenv.mkDerivation {
          pname = "mbed-os-src";
          version = "0.1.0";

          src = builtins.fetchGit {
            url = "https://github.com/mbed-ce/mbed-os.git";
            ref = "master";
            rev = "4ba00162ba2d73c64583018983391e1dfeaee83d";
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

            cat <<EOF > $out/lib/cmake/Findmbed-ce.cmake
            set(mbed-ce_SOURCE_DIR ${mbed-os-src})

            include(FindPackageHandleStandardArgs)
            find_package_handle_standard_args(mbed-ce
              REQUIRED_VARS
                mbed-ce_SOURCE_DIR
            )
            EOF
          '';
        };

        test = pkgs.stdenv.mkDerivation {
          pname = "libs-cmake-test";
          version = "0.1.0";

          src = ./test;

          nativeBuildInputs = [
            pkgs.cmake
            libs-cmake
          ];

          cmakeFlags = [
            "-DCMAKE_BUILD_TYPE=Debug"
            "-DCMAKE_MODULE_PATH=${libs-cmake}/lib/cmake"
          ];
        };
      };
    };
}
