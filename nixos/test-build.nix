{ pkgs ? import <nixpkgs> {} }:
let
  flake = builtins.getFlake (toString ./.);
  hyprlandPkg = flake.inputs.hyprland.packages.${pkgs.system}.hyprland;
in
pkgs.stdenv.mkDerivation {
  pname = "hyprglass";
  version = "main";
  src = pkgs.fetchFromGitHub {
    owner = "hyprnux";
    repo = "hyprglass";
    rev = "main";
    sha256 = "1syh50nkrz931qspnb93ijv5bkx30n8bb2p5zia7jp9y8vi7rzn7";
  };
  nativeBuildInputs = [ pkgs.pkg-config pkgs.wayland-scanner ];
  buildInputs = [
    hyprlandPkg
    pkgs.aquamarine
    pkgs.pixman
    pkgs.libdrm
    pkgs.wayland
    pkgs.wayland-protocols
  ];
  buildPhase = ''
    make all
  '';
  installPhase = ''
    mkdir -p $out/lib
    cp hyprglass.so $out/lib/
  '';
}
