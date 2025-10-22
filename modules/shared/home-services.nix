{
  user,
  pkgs,
  ...
}: {
  # Podman 配置
  podman = {
    enable = true;
    package = pkgs.podman;
  };
}