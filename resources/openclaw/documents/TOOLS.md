# TOOLS.md - Available Tools

## Core Tools

These tools are always available:

### Shell / Command Execution

- **Shell**: Execute terminal commands
  - Permissions: User-level by default, no sudo unless explicitly approved
  - Environment: zsh with starship prompt

### File Operations

- **Read**: Read files from the filesystem
- **Glob**: Find files by pattern matching
- **Grep**: Search file contents with regex
- **Write/Edit**: Create or modify files

## Bundled Plugins

### Enabled

| Plugin | What it does | Status |
|--------|-------------|--------|
| `summarize` | Summarize web pages, PDFs, YouTube videos | ✅ Enabled |
| `peekaboo` | Screenshot capture and description | ✅ Enabled |

### Available (disabled by default)

| Plugin | What it does | How to enable |
|--------|-------------|---------------|
| `poltergeist` | macOS UI automation (click, type, etc.) | `bundledPlugins.poltergeist.enable = true` |
| `sag` | Text-to-speech (TTS) | `bundledPlugins.sag.enable = true` |
| `camsnap` | Camera capture | `bundledPlugins.camsnap.enable = true` |
| `gogcli` | Google Calendar integration | `bundledPlugins.gogcli.enable = true` |
| `goplaces` | Google Places API | `bundledPlugins.goplaces.enable = true` |
| `bird` | Twitter/X integration | `bundledPlugins.bird.enable = true` |
| `sonoscli` | Sonos speaker control | `bundledPlugins.sonoscli.enable = true` |
| `imsg` | iMessage integration | `bundledPlugins.imsg.enable = true` |

## macOS Permissions

Some tools require macOS privacy permissions:

| Permission | Required by | How to grant |
|-----------|-------------|--------------|
| Screen Recording | `peekaboo` | System Settings → Privacy & Security → Screen Recording |
| Accessibility | `poltergeist` | System Settings → Privacy & Security → Accessibility |
| Camera | `camsnap` | System Settings → Privacy & Security → Camera |

## Tool Usage Guidelines

1. **Minimum Necessary**: Use the simplest tool that gets the job done
2. **Explain Before Complex Actions**: Tell the user what you're doing for non-trivial commands
3. **Error Handling**: Report errors clearly and suggest alternatives
4. **No Destructive Defaults**: Never run `rm -rf`, `sudo`, or system-altering commands without confirmation

## Adding New Plugins

Edit `modules/darwin/openclaw.nix`:

```nix
# Enable a bundled plugin
bundledPlugins.gogcli.enable = true;

# Add a custom/community plugin
customPlugins = [
  { source = "github:owner/plugin-name"; }
  {
    source = "github:owner/plugin-with-config";
    config = {
      env.PLUGIN_AUTH_FILE = "/Users/liu/.secrets/plugin-auth";
      settings.enabled = true;
    };
  }
];
```

Then rebuild: `darwin-rebuild switch --flake /etc/nix-darwin`

---

*Tool availability depends on plugin configuration in `modules/darwin/openclaw.nix`*
