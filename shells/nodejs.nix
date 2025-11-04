{ pkgs, ... }:

{
  nodejs18 = pkgs.mkShell {
    name = "nodejs-18-env";
    
    buildInputs = with pkgs; [
      nodejs_18
      nodePackages.npm
      nodePackages.pnpm
      yarn
    ];
    
    shellHook = ''
      echo "════════════════════════════════════════"
      echo "  Node.js 18 开发环境"
      echo "════════════════════════════════════════"
      echo "Node:  $(node --version)"
      echo "NPM:   $(npm --version)"
      echo "PNPM:  $(pnpm --version)"
      echo "Yarn:  $(yarn --version)"
      echo "════════════════════════════════════════"
      
      export PATH="$PWD/node_modules/.bin:$PATH"
      export NODE_ENV=development
    '';
  };
}
