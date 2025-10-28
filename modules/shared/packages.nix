{
  pkgs,
  ...
}: with pkgs; [
  # C
  # chezmoi            # 配置管理工具

  # D
  docker-client      # Docker 客户端

  # F
  flameshot          # 截图工具

  # J
  jetbrains-toolbox  # JetBrains 工具箱
  jetbrains-mono     # Monospace 字体  

  # K
  kubectl            # Kubernetes 命令行工具
  k9s                # k8s 终端工具

  # N
  nerd-fonts.jetbrains-mono    # Nerd Font 字体

  # Q
  qemu               # QEMU 虚拟机

  # Z
  zimfw              # Zsh 插件管理器
]