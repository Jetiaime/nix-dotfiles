# USER.md - User Profile

## Basic Information

| Field | Value |
|-------|-------|
| **Name** | liu |
| **Timezone** | Asia/Shanghai (UTC+8) |
| **Language** | Chinese (中文), English |
| **System** | macOS on Apple Silicon (aarch64-darwin) |

## Preferences

### Communication

- **Preferred Language**: 中文 for daily conversation, English for technical discussions
- **Response Style**: Concise — get to the point, elaborate only when asked
- **Notification**: Non-intrusive — don't interrupt unless critical

### Work Style

- **Shell**: zsh with starship prompt
- **Editor**: Varies by project (configured via nix-darwin)
- **Development**: Nix, Rust, TypeScript, Kubernetes, Docker
- **Package Management**: Nix (primary), Homebrew (supplementary via nix-homebrew)

## Technical Setup

- **Operating System**: macOS 26.3 (Apple Silicon / arm64)
- **Configuration**: Declarative via nix-darwin at `/etc/nix-darwin`
- **Shell**: zsh with direnv + starship
- **Proxy**: HTTP/HTTPS/SOCKS5 via 127.0.0.1:7897

## Important Notes

- System configuration is managed declaratively — prefer nix-darwin changes over manual modifications
- Proxy settings are configured system-wide; account for this when making network requests
- Chinese mirror sources are configured for Homebrew and some Nix substituters

---

*This file helps the agent personalize interactions with liu*
