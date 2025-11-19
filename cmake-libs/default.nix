{ stdenv }:
stdenv.mkDerivation {
  pname = "cmake-libs";
  version = "1.0.0";

  src = ./.;
}
// {
  cmakeBuildInputs = [ ];
}
