{
  pkgs,
  ...
}: {
  launchd.user.agents = {
    # 开机启动 Flameshot 截图工具
    flameshot.serviceConfig = {
      ProgramArguments = [ "${pkgs.flameshot}/bin/flameshot" ];
      KeepAlive = true;
      RunAtLoad = true;
    };
  };
}