{
  lib,
  ...
}: let
  inherit (lib) types mkOption mapAttrs;
in rec {
  mkOpt = type: default: description: mkOption { inherit type default description; };

  mkOpt' = type: default: mkOpt type default null;

  mkBoolOpt = mkOpt types.bool;
  
  mkBoolOpt' = mkOpt' types.bool;

  mkStrOpt = mkOpt types.str;
  mkStrOpt' = mkOpt' types.str;

  mkIntOpt = mkOpt types.int;
  mkIntOpt' = mkOpt' types.int;

  mkAttrsOpt = mkOpt types.attrs;
  mkAttrsOpt' = mkOpt' types.attrs;

  enabled = {
    enable = true;
  };

  disabled = {
    enable = false;
  };

  force-attrs = mapAttrs (_key: lib.mkForce);

}
