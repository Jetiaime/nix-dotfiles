{
  lib,
  ...
}: {
  imports = [ (lib.snowfall.fs.get-file "modules/common/system/default.nix") ];
}