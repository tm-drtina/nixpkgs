{ lib, bundlerApp, mkShell, bundix, defaultGemConfig }:

let app = bundlerApp {
    pname = "asciidoctor";
    gemdir = ./.;

    exes = [
      "asciidoctor"
      "asciidoctor-pdf"
      "asciidoctor-safe"
    ];

    meta = with lib; {
      description = "A faster Asciidoc processor written in Ruby";
      homepage = https://asciidoctor.org/;
      license = licenses.mit;
      maintainers = with maintainers; [ gpyh ];
      platforms = platforms.unix;
    };
  };

  shell = mkShell { 
    buildInputs = 
      app.gems.mathematical.buildInputs ++ 
      [ bundix ]; 
  };
in app.overrideAttrs (attrs: { passthru = attrs.passthru // { updateShell = shell; }; })
