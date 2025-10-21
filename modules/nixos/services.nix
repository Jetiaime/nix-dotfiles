{
  user,
  pkgs,
  ...
}: {
  # Flameshot 截图工具配置
  flameshot = {
   enable = true;
   package = pkgs.flameshot;  
  };
}