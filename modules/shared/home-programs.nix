{
  user,
  pkgs,
  ...
}: {
  # Claude
  claude-code = {
    enable = true;
    package = pkgs.claude-code;
  };

  direnv = {
    enable = true;
    nix-direnv.enable = true;
    package = pkgs.direnv;
  };

  # Git 配置
  git = {
    enable = true;
    package = pkgs.git;
    settings.user.name = "TeAmo";
    settings.user.email = "liu.junhui3@iwhalecloud.com";
    ignores = [
      ".DS_Store"
      "*.swp"
    ];
    lfs.enable = true;
  };

  # SSH 配置
  ssh = {
    enable = true;
    package = pkgs.openssh;
    enableDefaultConfig = false;
  };

  # Startship 提示符配置
  starship = {
    enable = true;
    package = pkgs.starship;
    enableInteractive = true;
    enableZshIntegration = true;
  };

  # 启动 zsh
  zsh = {
    enable = true;                      # 启动 zsh
    enableCompletion = true;            # 启动补全
    package = pkgs.zsh;                 # 使用 pkgs 的 zsh 包
    shellAliases = {
      ll = "ls -la";
      ",data" = "cd ~/Data";
      ",vpn" = "export https_proxy=http://127.0.0.1:7897 http_proxy=http://127.0.0.1:7897 all_proxy=socks5://127.0.0.1:7897";
      ",ssh_au" = "ssh -o HostKeyAlgorithms=+ssh-rsa 0027026800@10.20.50.1";
    };
  };
}
