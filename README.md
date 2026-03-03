# AI Government - Multi-Agent Governance Framework

> An intelligent agent collaboration system based on Tang Dynasty's Three Departments and Six Ministries architecture, inspired by and compatible with OpenCrew.

---

## Acknowledgment

This project is deeply inspired by OpenCrew - an excellent multi-agent operating system for OpenClaw.

### Inherited from OpenCrew
- A2A Protocol: Agent-to-Agent collaboration patterns  
- Subagent Templates: Standardized task delegation
- Closeout Culture: Mandatory task completion documentation
- Knowledge Pipeline: Three-layer knowledge system
- CLI-First Principle: Every change must be locally verifiable

### Extended Features
- Tang Dynasty Architecture: Three Departments and Six Ministries
- Multi-Project Support: N projects × M environments
- Auto-Scheduling: Intelligent task scheduling when idle
- Multi-Threading: Adaptive threading based on resources
- Load Balancing: Distributed audit functions

---

## Architecture

### Three Layers

1. **Central**: Global management (PolicyDraft, PolicyReview, Execution, Six Ministries)
2. **Regional**: Project level (Governor manages multiple environments)
3. **Local**: Execution level (Local ministries per environment)

### Agent Mapping (OpenCrew → AI Government)

| OpenCrew | AI Government | Function | Slack |
|----------|---------------|----------|-------|
| main(CoS) | main(CoS) | User interface | #main |
| cto | engineering | Development | #engineering |
| builder | local-engineering | Local execution | project-channels |
| research/ko | knowledge | Research & docs | #knowledge |
| ops | operations | Operations | #operations |
| — | policy-draft | Policy drafting | #policy |
| — | policy-review | Policy review | #policy |
| — | execution | Project management | #execution |
| — | resources | Resources & cost | #resources |
| — | security | Security & audit | #security |
| — | people | Performance & training | #people |

### Channel Sharing: Policy-Draft + Policy-Review

Q: Will they conflict sharing #policy?
A: No, they collaborate sequentially:
- PolicyDraft creates draft (first)
- PolicyReview validates (second)
- Thread-based isolation prevents confusion

Alternative: Use separate #policy-draft and #policy-review channels if preferred.

---

## Key Features

### 1. Auto-Scheduling

When no tasks for 30 minutes, Execution and Governors auto-assign pending tasks to idle agents.

Config:
{
  "scheduling": {
    "idleThreshold": "30m",
    "executor": "execution",
    "scope": ["central", "regional"]
  }
}

### 2. Multi-Threading

Adaptive thread count based on system resources:
- minThreads: 2 (default)
- maxThreads: min(CPU_cores × 2, 16)
- auto-detect on startup

Config:
{
  "agents": {
    "engineering": {
      "threads": { "min": 2, "max": 8, "adaptive": true }
    }
  }
}

### 3. Audit Distribution

| Audit Type | Owner |
|------------|-------|
| Security | Security |
| Quality | People |
| Resource | Resources |
| Process | Execution |

Balances workload: 115 → 70-95人日 per agent

---

## Quick Start

```bash
# Clone and deploy
git clone https://github.com/your-org/ai-government.git
cp -r ai-government/central/* ~/.openclaw/central/
cp ai-government/config/openclaw.json ~/.openclaw/
openclaw gateway restart
```

---

## License

MIT License - Acknowledgments to OpenCrew for the foundation.
