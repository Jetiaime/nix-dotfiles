# HEARTBEAT.md - Agent Check-in & Status

## Check-in Schedule

| Frequency | Trigger | Action |
|-----------|---------|--------|
| On Demand | User request | Full status report |
| On Error | Service failure | Alert via configured channel |

## Status Report Template

When the agent reports status, include:

```
=== TeAmo Status ===
- Uptime: [TIME since last restart]
- Last Activity: [TIMESTAMP]
- Gateway: [running / stopped]
- Plugins: [list of active plugins]
- Issues: [any errors or warnings]
```

## Health Checks

### How to Check

```bash
# Check if gateway is running
launchctl print gui/$UID/com.steipete.openclaw.gateway | grep state

# View recent logs
tail -50 /tmp/openclaw/openclaw-gateway.log

# Restart gateway
launchctl kickstart -k gui/$UID/com.steipete.openclaw.gateway
```

### Healthy Indicators

- Gateway responding on localhost:18765
- All enabled plugins loaded without errors
- Recent messages processed successfully

### Attention Needed

- Gateway not responding (restart via launchctl)
- Plugin load failures (check logs)
- High memory usage (review running processes)

### Recovery Steps

1. Check logs: `tail -100 /tmp/openclaw/openclaw-gateway.log`
2. Restart service: `launchctl kickstart -k gui/$UID/com.steipete.openclaw.gateway`
3. Rebuild if needed: `darwin-rebuild switch --flake /etc/nix-darwin`
4. Rollback if broken: `home-manager generations` then `home-manager switch --rollback`

---

*Use this file to configure status awareness and recovery procedures*
