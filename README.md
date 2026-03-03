# AI Government - Multi-Agent Governance Framework

> An intelligent agent collaboration system based on Tang Dynasty architecture, inspired by OpenCrew.

## Acknowledgment

Inspired by OpenCrew. Extended with Tang Dynasty Three Departments and Six Ministries.

---

## Deployment

### Prerequisites

- OpenClaw installed
- Git
- Node.js 20+

### Step 1: Clone

```bash
git clone https://github.com/fenix19830717a-sudo/China-opencrew.git ~/.openclaw/ai-government
cd ~/.openclaw/ai-government
```

### Step 2: Deploy (Default: Regional)

Default is Regional. Copy agents as needed:

```bash
cp -r workspaces/main ~/.openclaw/
cp -r workspaces/engineering ~/.openclaw/
```

### Step 3: Configure

Edit ~/.openclaw/openclaw.json

### Step 4: Start

```bash
openclaw gateway restart
```

---

## Capital vs Regional

### Default: Regional

Every device defaults to Regional:
- Executes tasks locally
- Reports to Capital via GitHub
- Receives commands from Capital

### Upgrade to Capital

To make a device the Capital:

```bash
# Copy additional agents for capital
cp -r workspaces/policy-draft ~/.openclaw/
cp -r workspaces/policy-review ~/.openclaw/
cp -r workspaces/execution ~/.openclaw/
cp -r workspaces/resources ~/.openclaw/
cp -r workspaces/operations ~/.openclaw/
cp -r workspaces/security ~/.openclaw/
cp -r workspaces/knowledge ~/.openclaw/
cp -r workspaces/people ~/.openclaw/

# Mark as capital
echo "MODE=capital" > ~/.openclaw/config/mode
```

Capital Functions:
- Publish tasks to Regional nodes
- Receive reports from Regional nodes
- Manage global policies

---

## Documentation

- A2A Protocol: shared/A2A_PROTOCOL.md
- System Rules: shared/SYSTEM_RULES.md
- Task Protocol: shared/TASK_PROTOCOL.md

## License

MIT License - Acknowledgments to OpenCrew.
