{
  lib,
  user,
  config,
  ...
}: {
  system.defaults = {
    # 自动更新
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;

    # finder 设置
    finder = {
      # 显示完整的 Posix 路径
      _FXShowPosixPathInTitle = true;
      # 显示所有文件扩展名
      AppleShowAllExtensions = true;
      # 默认搜索当前文件夹
      FXDefaultSearchScope = "SCcf";
      # 显示路径栏
      ShowPathbar = true;
      # 显示状态栏
      ShowStatusBar = true;
    };

    # trackpad 设置
    trackpad = {
      # 轻点以点击
      Clicking = true;
      # 启用辅助点按
      Dragging = true;
      # 启用三指拖拽
      TrackpadThreeFingerDrag = true;
    };

    dock = {
      # 不自动隐藏 dock 栏
      autohide = false;
      # 不显示最近使用的应用
      show-recents = false;
      # 最小化窗口时将其收纳到应用图标中
      minimize-to-application = true;
      # 悬停放大
      magnification = true;
      # dock 栏放置位置
      orientation = "bottom";

      # 设置 dock 栏常驻应用
      persistent-apps = [
        "/System/Applications/Calendar.app"
        "/Applications/TickTick.app"
        "/Applications/WezTerm.app"
        "/Applications/Obsidian.app"
        "/Applications/Visual Studio Code.app"
        "/Applications/Zed.app"
        "${config.users.users.${user}.home}/Applications/IntelliJ IDEA.app"
        "${config.users.users.${user}.home}/Applications/GoLand.app"
        "/Applications/Zen.app"
        "/Applications/Spotify.app"
        { spacer.small = true; }
      ];

      # 设置 dock 栏常驻文件夹
      persistent-others = [
        "${config.users.users.${user}.home}/Downloads"
      ];
    };
  };
}