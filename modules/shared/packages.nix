{
  pkgs,
  ...
}: with pkgs; [
  # C
  # chezmoi            # 配置管理工具
  cargo                # Rust 包管理器
  clippy               # Rust 代码检查工具

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

  # R
  rustc              # Rust 编译器
  rustfmt            # Rust 代码格式化工具
  rust-analyzer      # Rust 语言服务器

  # U
  unar               # 解压工具

  # Z
  zimfw              # Zsh 插件管理器
]