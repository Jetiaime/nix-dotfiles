{ pkgs, ... }:

let
  nodejsShells = import ./nodejs.nix { inherit pkgs; };
  golangShells = import ./golang.nix { inherit pkgs; };
in
{
  # 默认开发环境
  default = pkgs.mkShell {
    name = "default-dev-env";

    buildInputs = with pkgs; [
      git
      curl
      wget
      vim
    ];

    shellHook = ''
      echo "默认开发环境"
      echo "提示: 使用 'nix develop .#golang' 进入 Go 环境"
      echo "提示: 使用 'nix develop .#nodejs22' 进入 Node.js 环境"
    '';
  };

  # 导入 Node.js 相关环境
  inherit (nodejsShells) nodejs22 frontend;
  # 导入 Go 相关环境
  inherit (golangShells) golang;
}
