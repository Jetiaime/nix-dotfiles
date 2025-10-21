{
  pkgs,
  ...
}: with pkgs;
let 
  shared = import ../shared/packages.nix { inherit pkgs; };
in shared ++ [
  # R
  raycast     # App 启动器

  # W
  wechat      # 微信
]
