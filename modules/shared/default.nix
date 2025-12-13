{
  # Nix 包管理器设置
  nix.settings = {
    # 启用实验性功能
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # 添加国内镜像源
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
      # "https://mirror.sjtu.edu.cn/nix-channels/store"
      # "https://mirrors.ustc.edu.cn/nix-channels/store"
    ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # Nixpkgs 配置
  nixpkgs = {
    # 允许使用非自由软件
    config.allowUnfree = true;
  };
}