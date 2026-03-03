{ pkgs, ... }:

{
  nodejs22 = pkgs.mkShell {
    name = "nodejs-22-env";

    buildInputs = with pkgs; [
      nodejs_22
      nodePackages.pnpm
    ];

    shellHook = ''
      echo "════════════════════════════════════════"
      echo "  Node.js 22 开发环境"
      echo "════════════════════════════════════════"
      echo "Node:  $(node --version)"
      echo "PNPM:  $(pnpm --version)"
      echo "════════════════════════════════════════"

      export PATH="$PWD/node_modules/.bin:$PATH"
      export NODE_ENV=development
    '';
  };
}
