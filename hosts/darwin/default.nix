{
  user,
  pkgs,
  config,
  openspec,
  ...
}: {
  imports = [
    ../../modules/shared
    ../../modules/darwin/ui.nix
    ../../modules/darwin/home.nix
    ../../modules/darwin/launchd.nix
  ];

  # 系统软件包
  environment = {
    systemPackages = with pkgs; [
      vim                # 文本编辑器
      htop               # 交互式进程查看器
      wget               # 文件下载工具
      git                # 版本控制系统
      unzip              # 解压工具
      openspec.packages.${pkgs.system}.default  # Spec-driven development CLI
    ];

    variables = {
      KIND_EXPERIMENTAL_PROVIDER = "nerdctl";
      PATH = "$HOME/.rd/bin:$PATH";
      http_proxy = "http://127.0.0.1:7897";
      all_proxy = "socks5://127.0.0.1:7897";
      https_proxy = "http://127.0.0.1:7897";
      # Homebrew 国内镜像源（USTC）
      HOMEBREW_API_DOMAIN = "https://mirrors.ustc.edu.cn/homebrew-bottles/api";
      HOMEBREW_BOTTLE_DOMAIN = "https://mirrors.ustc.edu.cn/homebrew-bottles";
      HOMEBREW_BREW_GIT_REMOTE = "https://mirrors.ustc.edu.cn/brew.git";
      HOMEBREW_CORE_GIT_REMOTE = "https://mirrors.ustc.edu.cn/homebrew-core.git";
    };
  };

  # 设置当前 MacOS 架构为 ARM
  nixpkgs.hostPlatform = "aarch64-darwin";

  # nix-darwin 的 macos 设置
  system = {
    # 用于设置 git commit hash for darwin-version
    # configurationRevision = self.rev or self.dirtyRev or null

    # 设置主要用户
    primaryUser = user;

    # 用于向后兼容性
    stateVersion = 6;
  };
}