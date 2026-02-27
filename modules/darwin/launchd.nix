{
  pkgs,
  ...
}: {
  launchd = {
    daemons.nix-daemon.serviceConfig.EnvironmentVariables = {
      http_proxy = "http://127.0.0.1:7897";
      https_proxy = "http://127.0.0.1:7897";
      all_proxy = "http://127.0.0.1:7897";
    };

    user.agents = {
      # 开机启动 Flameshot 截图工具
      flameshot.serviceConfig = {
        ProgramArguments = [ "${pkgs.flameshot}/bin/flameshot" ];
        KeepAlive = true;
        RunAtLoad = true;
      };
    };
  };
}