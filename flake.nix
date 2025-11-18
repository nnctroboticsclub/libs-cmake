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
        libs-cmake =
          pkgs.stdenv.mkDerivation {
            pname = "libs-cmake";
            version = "0.1.0";

            src = ./.;

            nativeBuildInputs = [
              pkgs.cmake
            ];
            buildInputs = [
              # mbed-os
            ];
          }
          // {
            cmakeBuildInputs = [ ];
          };

        gcc-arm-toolchain =
          pkgs.stdenv.mkDerivation {
            pname = "gcc-arm-toolchain";
            version = "0.1.0";

            src = ./.;

            cmakeBuildInputs = [ ];

            buildPhase =
              let
                prefix = "${pkgs.gcc-arm-embedded}/bin/arm-none-eabi";
              in
              ''
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
          }
          // {
            cmakeBuildInputs = [ ];
          };
      };
    };
}
