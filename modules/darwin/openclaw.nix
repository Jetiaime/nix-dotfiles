{
  pkgs,
  user,
  nix-openclaw,
  lib,
  ...
}:
let
  # Secrets are read at activation time (shell), not at Nix eval time,
  # so they don't need to be tracked by git or copied into the Nix store.
  secretsDir = "/etc/nix-darwin/resources/openclaw";

  # Model lists (no secrets) — embedded at eval time
  claudeModels = [
    { id = "claude-opus-4-6-20260205"; name = "Claude Opus 4.6";   contextWindow = 200000; maxTokens = 64000; reasoning = false; input = [ "text" "image" ]; cost = { input = 0; output = 0; cacheRead = 0; cacheWrite = 0; }; }
    { id = "claude-sonnet-4-6";        name = "Claude Sonnet 4.6"; contextWindow = 200000; maxTokens = 64000; reasoning = false; input = [ "text" "image" ]; cost = { input = 0; output = 0; cacheRead = 0; cacheWrite = 0; }; }
    { id = "claude-haiku-4-5-20251001"; name = "Claude Haiku 4.5"; contextWindow = 200000; maxTokens = 8192;  reasoning = false; input = [ "text" "image" ]; cost = { input = 0; output = 0; cacheRead = 0; cacheWrite = 0; }; }
    { id = "claude-opus-4-5-20251101";  name = "Claude Opus 4.5";  contextWindow = 180000; maxTokens = 64000; reasoning = false; input = [ "text" "image" ]; cost = { input = 0; output = 0; cacheRead = 0; cacheWrite = 0; }; }
  ];
  gptModels = [
    { id = "gpt-5.3-codex"; name = "GPT-5.3 Codex"; contextWindow = 400000; maxTokens = 128000; reasoning = false; input = [ "text" "image" ]; cost = { input = 0; output = 0; cacheRead = 0; cacheWrite = 0; }; }
    { id = "gpt-5.2";       name = "GPT-5.2";        contextWindow = 400000; maxTokens = 128000; reasoning = false; input = [ "text" "image" ]; cost = { input = 0; output = 0; cacheRead = 0; cacheWrite = 0; }; }
  ];
  geminiModels = [
    { id = "gemini-3-pro"; name = "Gemini 3 Pro"; contextWindow = 1048576; maxTokens = 65536; reasoning = false; input = [ "text" "image" ]; cost = { input = 0; output = 0; cacheRead = 0; cacheWrite = 0; }; }
  ];

  # Static part of the extra-config patch (no secrets). All secrets
  # are substituted at activation time via shell variable expansion.
  extraConfigTemplate = builtins.toJSON {
    channels."dingtalk-connector" = {
      enabled = true;
      clientId = "__DINGTALK_CLIENT_ID__";
      clientSecret = "__DINGTALK_CLIENT_SECRET__";
      gatewayToken = "__GATEWAY_TOKEN__";
    };
    auth.order = {
      "aicodewith-gpt"    = [ "aicodewith:default" ];
      "aicodewith-claude" = [ "aicodewith:default" ];
      "aicodewith-gemini" = [ "aicodewith:default" ];
    };
    models.providers = {
      "aicodewith-gpt" = {
        baseUrl = "https://api.aicodewith.com/chatgpt/v1";
        api = "openai-responses";
        apiKey = "__AICODEWITH_API_KEY__";
        models = gptModels;
      };
      "aicodewith-claude" = {
        baseUrl = "https://api.aicodewith.com";
        api = "anthropic-messages";
        apiKey = "__AICODEWITH_API_KEY__";
        models = claudeModels;
      };
      "aicodewith-gemini" = {
        baseUrl = "https://api.aicodewith.com/gemini_cli/v1beta";
        api = "google-generative-ai";
        apiKey = "__AICODEWITH_API_KEY__";
        models = geminiModels;
      };
    };
  };
in
{
  # Import the nix-openclaw darwin module (injects HM sharedModule)
  imports = [
    nix-openclaw.darwinModules.openclaw
  ];

  # OpenClaw is configured in home-manager below
  home-manager.users.${user} =
    { config, lib, ... }:
    {
      programs.openclaw = {
        enable = true;

        # Batteries-included package (gateway + app + tools)
        package = pkgs.openclaw;

        # Documents directory with AGENTS.md, SOUL.md, TOOLS.md, etc.
        documents = ../../resources/openclaw/documents;

        # Exclude tools already managed by nix-darwin
        excludeTools = [
          "git"
          "ripgrep"
        ];

        # Schema-typed OpenClaw config (only fields known to nix-openclaw schema).
        # Secrets (gateway token) are read from the secrets file at activation time.
        config = {
          gateway = {
            mode = "local";
            auth.token.__fromFile = "${secretsDir}/.gateway-token";
            http.endpoints.chatCompletions.enabled = true;
          };

          # Agent defaults
          agents.defaults = {
            workspace = "~/.openclaw/workspace";
            compaction.mode = "safeguard";
            model = "aicodewith-claude/claude-sonnet-4-6";
          };

          # Commands
          commands = {
            native = "auto";
            nativeSkills = "auto";
            restart = true;
            ownerDisplay = "raw";
          };
        };

        # Default instance with launchd service
        instances.default = {
          enable = true;
          package = pkgs.openclaw;
          stateDir = "~/.openclaw";
          workspaceDir = "~/.openclaw/workspace";
          launchd.enable = true;
        };

        # Bundled plugins
        bundledPlugins = {
          summarize.enable = true; # Summarize web pages, PDFs, videos
          peekaboo.enable = true;  # Take screenshots (macOS)
        };

        # Note: npm-only plugins are NOT manageable via customPlugins (which requires Nix flakes).
        # Install them once via CLI; their config is injected via home.activation below:
        #   openclaw plugins install @dingtalk-real-ai/dingtalk-connector
        #   openclaw plugins install openclaw-aicodewith-auth
      };

      # Patch extra config fields (not in nix-openclaw schema) into openclaw.json
      # after nix-openclaw has written the base config. Secrets are read at runtime
      # from ${secretsDir} — never embedded in the Nix store.
      home.activation.openclawExtraConfig = lib.hm.dag.entryAfter [ "openclawConfigFiles" ] ''
        _ocConfig="$HOME/.openclaw/openclaw.json"
        _secretsDir="${secretsDir}"

        _gatewayToken="$(${pkgs.coreutils}/bin/cat "$_secretsDir/.gateway-token" | ${pkgs.gnused}/bin/sed 's/[[:space:]]*$//')"
        _apiKey="$(${pkgs.coreutils}/bin/cat "$_secretsDir/.aicodewith-api-key" | ${pkgs.gnused}/bin/sed 's/[[:space:]]*$//')"
        _dingtalkClientId="$(${pkgs.coreutils}/bin/cat "$_secretsDir/.dingtalk-client-id" | ${pkgs.gnused}/bin/sed 's/[[:space:]]*$//')"
        _dingtalkClientSecret="$(${pkgs.coreutils}/bin/cat "$_secretsDir/.dingtalk-client-secret" | ${pkgs.gnused}/bin/sed 's/[[:space:]]*$//')"

        # Substitute placeholders in the template
        _patch="$(printf '%s' '${extraConfigTemplate}' \
          | ${pkgs.gnused}/bin/sed "s|__GATEWAY_TOKEN__|$_gatewayToken|g" \
          | ${pkgs.gnused}/bin/sed "s|__AICODEWITH_API_KEY__|$_apiKey|g" \
          | ${pkgs.gnused}/bin/sed "s|__DINGTALK_CLIENT_ID__|$_dingtalkClientId|g" \
          | ${pkgs.gnused}/bin/sed "s|__DINGTALK_CLIENT_SECRET__|$_dingtalkClientSecret|g")"

        if [ -f "$_ocConfig" ]; then
          _merged="$(${pkgs.jq}/bin/jq -s '.[0] * .[1]' "$_ocConfig" - <<< "$_patch")"
          # If $_ocConfig is a symlink (e.g. pointing into the read-only Nix store),
          # remove it first so we can write a real mutable file in its place.
          if [ -L "$_ocConfig" ]; then
            rm "$_ocConfig"
          fi
          printf '%s\n' "$_merged" > "$_ocConfig"
        fi
      '';
    };
}
