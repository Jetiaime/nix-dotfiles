{
  pkgs,
  ...
}: with pkgs;
let 
  shared = import ../shared/packages.nix { inherit pkgs; };
in shared ++ [
  # K
  kind        # Kubernetes 本地集群工具
  kubectl     # Kubernetes 命令行工具

  # R
  raycast     # App 启动器

  # W
  wechat      # 微信
]
