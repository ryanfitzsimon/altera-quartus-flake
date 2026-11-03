{ pkgs-19_03 }:

let

  sources = import ./sources.nix { inherit (pkgs-19_03) fetchurl; };

  buildQuartus =
  let
      in import ./generic.nix {
    inherit (pkgs-19_03)
      lib stdenv fetchurl utillinux file bash writeScript
      nukeReferences pax-utils libfaketime coreutils gnugrep gnused proot
      # Runtime libraries:
      zlib glib libpng12 freetype fontconfig gtk2 bzip2 libelf xorg
      glibc glibcLocales pkgsi686Linux;
  };

  mkCommonQuartus = srcAttrs:
    buildQuartus {
      inherit (srcAttrs) baseName prettyName is32bitPackage;
      version = srcAttrs.updates.version;
      components = with srcAttrs.components; [
        quartus cyclonev
      ];
      updateComponents = with srcAttrs.updates.components; [
        quartus
      ];
    };

in rec {

  inherit sources;

  altera-quartus-ii-web-13_0_sp1 =
    let
      srcAttrs = sources.v13_0_sp1.web_edition;
    in
    buildQuartus {
      inherit (srcAttrs) baseName prettyName is32bitPackage version;
      components = with srcAttrs.components; [
        quartus cyclone modelsim
      ];
      updateComponents = [];
    };

  altera-quartus-ii-web-13 =
    mkCommonQuartus sources.v13.web_edition;

  altera-quartus-ii-subscription-13 =
    mkCommonQuartus sources.v13.subscription_edition;

  altera-quartus-ii-web-14 =
    mkCommonQuartus sources.v14.web_edition;

  altera-quartus-ii-subscription-14 =
    mkCommonQuartus sources.v14.subscription_edition;

  altera-quartus-prime-lite-15 =
    mkCommonQuartus sources.v15.lite_edition;

  altera-quartus-prime-standard-15 =
    mkCommonQuartus sources.v15.standard_edition;

  altera-quartus-prime-lite-16 =
    mkCommonQuartus sources.v16.lite_edition;

  altera-quartus-prime-standard-16 =
    mkCommonQuartus sources.v16.standard_edition;

  altera-quartus-prime-lite-17 =
    mkCommonQuartus sources.v17.lite_edition;

  altera-quartus-prime-standard-17 =
    mkCommonQuartus sources.v17.standard_edition;

  # Aliases to latest versions
  altera-quartus-prime-lite = altera-quartus-prime-lite-17;
  altera-quartus-prime-standard = altera-quartus-prime-standard-17;

}
