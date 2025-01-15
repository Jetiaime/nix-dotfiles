{
  lib,
  host,
  namespace,
  ...
}: let
  inherit (lib.${namespace}) mkStrOpt;
in {
  options.${namespace}.host = {
    name = mkStrOpt host "The name of the host.";
  };
}
