# AI Government 配置片段

## Agents 配置

```json
{
  "agents": {
    "list": [
      {
        "id": "steward",
        "name": "大内总管",
        "workspace": "~/.openclaw/workspace-aigovernment/workspaces/steward",
        "subagents": {"allowAgents": ["steward"]}
      },
      {
        "id": "chancellery",
        "name": "中书省",
        "workspace": "~/.openclaw/workspace-aigovernment/workspaces/chancellery",
        "subagents": {"allowAgents": ["chancellery", "inspectorate"]}
      },
      {
        "id": "inspectorate",
        "name": "门下省",
        "workspace": "~/.openclaw/workspace-aigovernment/workspaces/inspectorate",
        "subagents": {"allowAgents": ["inspectorate"]}
      },
      {
        "id": "state-affairs",
        "name": "尚书省",
        "workspace": "~/.openclaw/workspace-aigovernment/workspaces/state",
        "subagents": {"allowAgents": ["state-affairs", "revenue", "works", "justice", "war", "rites", "personnel"]}
      },
      {
        "id": "works",
        "name": "工部",
        "workspace": "~/.openclaw/workspace-aigovernment/workspaces/works",
        "subagents": {"allowAgents": ["works", "builder", "research"]}
      }
    ]
  }
}
```

## Bindings 配置

```json
{
  "bindings": [
    {"agentId": "steward", "match": {"channel": "slack", "peer": {"kind": "channel", "id": "PALACE_INTERNAL_CHANNEL_ID"}}},
    {"agentId": "chancellery", "match": {"channel": "slack", "peer": {"kind": "channel", "id": "CHANCELLERY_CHANNEL_ID"}}},
    {"agentId": "inspectorate", "match": {"channel": "slack", "peer": {"kind": "channel", "id": "INSPECTORATE_CHANNEL_ID"}}},
    {"agentId": "state-affairs", "match": {"channel": "slack", "peer": {"kind": "channel", "id": "STATE_AFFAIRS_CHANNEL_ID"}}},
    {"agentId": "works", "match": {"channel": "slack", "peer": {"kind": "channel", "id": "WORKS_CHANNEL_ID"}}}
  ]
}
```

## 频道 Allowlist

```json
{
  "channels": {
    "slack": {
      "channels": {
        "PALACE_INTERNAL_CHANNEL_ID": {"allow": true, "requireMention": false},
        "CHANCELLERY_CHANNEL_ID": {"allow": true, "requireMention": false},
        "INSPECTORATE_CHANNEL_ID": {"allow": true, "requireMention": false},
        "STATE_AFFAIRS_CHANNEL_ID": {"allow": true, "requireMention": false},
        "WORKS_CHANNEL_ID": {"allow": true, "requireMention": false}
      }
    }
  }
}
```
