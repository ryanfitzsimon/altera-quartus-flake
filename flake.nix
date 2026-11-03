{
  description = "Altera Quartus (II / Prime) packaged for Nix";

  inputs = {
    # Quartus installers require a very old glibc 2.24 toolchain.
    # We build it from source, but even this is a challenge with newer compilers
    # in recent nixpkgs releases, so we use pinned dependencies from nixos-19.03.
    nixpkgs-19_03 = {
      url = "github:NixOS/nixpkgs/34c7eb7545d155cc5b6f499b23a7cb1c96ab4d59";
      flake = false;
    };
  };

  outputs = { self, nixpkgs-19_03 }:
    let
      system = "x86_64-linux";

      pkgs-19_03 = import nixpkgs-19_03 {
        inherit system;
        config.allowUnfree = true;
      };

      quartus = import ./pkgs/altera-quartus { inherit pkgs-19_03; };

      # Everything except the `sources` attrset is a derivation.
      quartusPackages = builtins.removeAttrs quartus [ "sources" ];
    in
    {
      packages.${system} = quartusPackages // {
        default = quartusPackages.altera-quartus-prime-lite;
      };

      overlays.default = final: prev: quartusPackages;

      lib.sources = quartus.sources;
    };
}

