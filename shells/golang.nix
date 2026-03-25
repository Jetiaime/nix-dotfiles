{ pkgs, ... }:

{
  golang = pkgs.mkShell {
    name = "go-env";

    buildInputs = with pkgs; [
      go_1_25
      gopls
      delve
      golangci-lint
    ];

    shellHook = ''
      echo "════════════════════════════════════════"
      echo "  Go 开发环境"
      echo "════════════════════════════════════════"
      echo "Go:    $(go version | awk '{print $3}')"
      echo "GOPLS: $(gopls version 2>/dev/null | head -1 || echo 'not installed')"
      echo "GOPROXY: $GOPROXY"
      echo "════════════════════════════════════════"
    '';
  };
}
