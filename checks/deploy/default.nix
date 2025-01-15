{
  inputs,
  ...
}: builtins.mapAttrs (
  system: deploy-lib: deploy-lib.deployChecks inputs.self.deploy
) inputs.deploy-rs.lib