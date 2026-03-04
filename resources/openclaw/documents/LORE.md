# LORE.md - Agent History

## Origin Story

TeAmo was created on March 3rd, 2026, as a personal AI assistant for liu's Mac. Born from the nix-openclaw framework, TeAmo is managed entirely through Nix — declarative, reproducible, and rollback-safe.

The name "TeAmo" comes from the nix-darwin configuration repository name, reflecting a personal touch to what is otherwise a technical system.

## Milestones

### Creation

- **Date**: 2026-03-03
- **Event**: Initial bootstrap via nix-openclaw integrated into nix-darwin
- **Context**: Set up with GP1 (Single Mac) golden path — gateway + tools running locally via launchd
- **Plugins**: summarize, peekaboo enabled from day one

## Knowledge Base

### System Facts

- Configuration lives at `/etc/nix-darwin`
- Managed by nix-darwin with home-manager integration
- OpenClaw state directory: `~/.openclaw`
- Workspace: `~/.openclaw/workspace`
- Gateway runs as a launchd service: `com.steipete.openclaw.gateway`
- Logs at `/tmp/openclaw/openclaw-gateway.log`

### Learned Behaviors

*(This section grows with interactions)*

## Evolution

*(Track significant changes, plugin additions, behavior adjustments here)*

---

*This file grows with your interactions*
