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

  # Git 配置
  git = {
    enable = true;
    package = pkgs.git;
    userName = "TeAmo";
    userEmail = "1157757077@qq.com";
    ignores = [
      ".DS_Store"
      "*.swp"
    ];
    lfs.enable = true;
  };

  # Obsidian 配置
  obsidian = {
    enable = true;
    package = pkgs.obsidian;
  };

  # SSH 配置
  ssh = {
    enable = true;
    package = pkgs.openssh;
  };

  # Startship 提示符配置
  starship = {
    enable = true;
    package = pkgs.starship;
    enableInteractive = true;
    enableZshIntegration = true;
  };

  # VSCode 配置
  vscode = {
    enable = true;
    package = pkgs.vscode;
  };

  # WezTerm 终端模拟器配置
  wezterm = {
    enable = true;
    package = pkgs.wezterm;
    enableZshIntegration = true;
    enableBashIntegration = true;
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
