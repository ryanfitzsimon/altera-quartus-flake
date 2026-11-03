# Altera Quartus packages for Nix

Based on altera-quartus package from [bjornfor/nixos-config](https://github.com/bjornfor/nixos-config) by Bjørn Forsman.

## Manual installer download

The Altera links (e.g. <https://download.altera.com/akdlm/software/acdsinst/13.0sp1/232/ib_installers/QuartusSetupWeb-13.0.1.232.run>) no longer seem to work with scripted download tools like curl, failing with 403 errors.
They can still be retrieved with browsers manually, then added to the nix store:

```sh
nix-store --add-fixed sha256 ~/Downloads/ModelSimSetup-13.0.1.232.run
nix-store --add-fixed sha256 ~/Downloads/cyclone_web-13.0.1.232.qdz
nix-store --add-fixed sha256 ~/Downloads/QuartusSetupWeb-13.0.1.232.run
```