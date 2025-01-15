{
  lib,
  inputs,
  namespace,
  ...
}: let
  inherit (inputs) deploy-rs;
in {
  mkDeploy = {
    self,
    overrides ? {},
  }: let
    inherit (lib) foldl optionalAttrs;
  
    hosts = self.nixosConfigurations or { };
    
    names = builtins.attrNames hosts;

    nodes = foldl ( result: name: let 
      host = hosts.${name};
      user = host.config.${namespace}.user.name;
    in 
      result // {
        ${name} = (overrides.${name} or { }) // {
          hostname = overrides.hostname or "${name}";
          profiles = (overrides.profiles or { }) // {
            system = (overrides.${name}.profiles.system or { }) // {
              path = deploy-rs.lib.${name}.activate.nixos host;
            } // optionalAttrs (user != "") {
              user = "root";
              sshUser = user;
            };
          };
        };
      }

    ) { } names;
  in {
    inherit nodes;
  };
}