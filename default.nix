{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "vinz";

  src = pkgs.fetchFromGitHub {
    owner = "vinz-ux";
    repo = "VinZ";
    rev = "main";
    sha256 = "sha256-CKZvxWBlMx7Ubcs5XqoIJ3+4A3N++Q0UTXDjNHnAoNU=";
  };

  nativeBuildInputs = [ 
    pkgs.makeWrapper 
  ];

  buildInputs = [ ];

        installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin
    cp vinz $out/bin/

    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "VinZ";
    homepage = "https://github.com";
    license = licenses.gpl3Only;
    platforms = platforms.unix;
  };
}

