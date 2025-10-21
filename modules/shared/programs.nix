{
  user,
  pkgs,
  ...
}: {
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

  # VSCode 配置
  vscode = {
    enable = true;
    package = pkgs.vscode;
  };

  # WezTerm 终端模拟器配置
  wezterm = {
    enable = true;
    package = pkgs.wezterm; # 修复拼写
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  # 启动 zsh
  zsh = {
    enable = true;
    package = pkgs.zsh;
  };
}
