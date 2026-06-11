{
  pkgs ? import <nixpkgs> { },
  lib ? pkgs.lib,
  stdenv ? pkgs.stdenv,
  fetchFromGitHub ? pkgs.fetchFromGitHub,
}:

stdenv.mkDerivation {
  pname = "vinz";
  version = "0-unstable-2026-04-25";

  src = fetchFromGitHub {
    owner = "vinz-ux";
    repo = "VinZ";
    rev = "main";
    hash = "sha256-CKZvxWBlMx7Ubcs5XqoIJ3+4A3N++Q0UTXDjNHnAoNU=";
  };

  buildPhase = ''
    runHook preBuild
    make
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp vinz $out/bin/vinz
    ln -s $out/bin/vinz $out/bin/vz

    runHook postInstall
  '';

  meta = {
    description = "A highly interactive, true-color, 3D raymarching, procedural graphics engine for the terminal";
    homepage = "https://github.com";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ lords1nister1 ];
    platforms = lib.platforms.unix;
    mainProgram = "vinz";
  };
}

