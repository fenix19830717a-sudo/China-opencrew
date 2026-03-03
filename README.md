# AI Government - Multi-Agent Governance Framework

> An intelligent agent collaboration system based on Tang Dynasty's Three Departments and Six Ministries architecture, inspired by and compatible with [OpenCrew](https://github.com/AlexAnys/opencrew).

**English** | [中文](#快速开始)

---

## 🙏 Acknowledgment

This project is deeply inspired by **[OpenCrew](https://github.com/AlexAnys/opencrew)** - an excellent multi-agent operating system for OpenClaw created by AlexAnys.

We inherited:
- A2A Protocol, Subagent Templates, Closeout Culture
- CLI-First Principle, Knowledge Pipeline

We extended:
- Tang Dynasty Architecture (Three Departments + Six Ministries)
- Multi-Project × Multi-Environment Support
- Auto-Scheduling, Adaptive Multi-Threading

---

## 🚀 One-Line Installation

```bash
curl -fsSL https://raw.githubusercontent.com/fenix19830717a-sudo/China-opencrew/main/install.sh | bash -s -- --capital
```

**That's it!** The installer will:
1. Detect your system and install dependencies
2. Clone the AI Government framework
3. Configure OpenClaw with default settings
4. Set this device as the **Capital** (central hub)

---

## 📋 Installation Modes

### Mode 1: Capital (中枢/首都) - Default

For your main control server:

```bash
# One-line install
curl -fsSL https://raw.githubusercontent.com/fenix19830717a-sudo/China-opencrew/main/install.sh | bash -s -- --capital

# Or with custom options
curl -fsSL .../install.sh | bash -s -- --capital \
  --slack-token "xoxb-xxx" \
  --slack-app-token "xapp-xxx" \
  --region "aliyun"
```

**What's installed:**
- Central layer: main(CoS) + Three Departments + Six Ministries
- Full governance capability
- Can manage regional deployments

### Mode 2: Regional (地方/州) - For additional servers

For project-specific servers:

```bash
# One-line install
curl -fsSL https://raw.githubusercontent.com/fenix19830717a-sudo/China-opencrew/main/install.sh | bash -s -- --regional

# Connect to capital
curl -fsSL .../install.sh | bash -s -- --regional \
  --capital-host "https://your-capital-server.com" \
  --project "my-project"
```

**What's installed:**
- Regional layer: Governor + Local Six Ministries
- Connects to Capital via GitHub
- Executes tasks locally

### Mode 3: Minimal (最小安装) - For development

```bash
curl -fsSL https://raw.githubusercontent.com/fenix19830717a-sudo/China-opencrew/main/install.sh | bash -s -- --minimal
```

Only installs essential agents: main + execution + engineering

---

## 🔧 Manual Installation (if one-line fails)

### Prerequisites

- Linux/macOS with bash
- OpenClaw installed (`npm install -g openclaw`)
- Git
- Slack workspace (optional but recommended)

### Step 1: Clone Repository

```bash
git clone https://github.com/fenix19830717a-sudo/China-opencrew.git ~/.openclaw/ai-government
cd ~/.openclaw/ai-government
```

### Step 2: Choose Installation Mode

#### For Capital (中枢):

```bash
# Copy central configuration
cp -r central/* ~/.openclaw/

# Configure as capital
cat > ~/.openclaw/config/mode << 'EOF'
MODE=capital
CAPITAL=true
EOF
```

#### For Regional (地方):

```bash
# Copy regional template
cp -r templates/regions/cloud-ali ~/.openclaw/regional/my-region

# Configure as regional
cat > ~/.openclaw/config/mode << 'EOF'
MODE=regional
CAPITAL_HOST=https://your-capital.com
PROJECT_NAME=my-project
EOF
```

### Step 3: Configure OpenClaw

```bash
# Copy configuration template
cp config/openclaw.json ~/.openclaw/

# Edit with your settings
nano ~/.openclaw/openclaw.json
```

Required fields:
```json
{
  "channels": {
    "slack": {
      "botToken": "xoxb-your-bot-token",
      "appToken": "xapp-your-app-token"
    }
  }
}
```

### Step 4: Initialize

```bash
# Run initialization script
./scripts/init.sh

# Or manually:
openclaw channels add --channel slack \
  --slack-bot-token "xoxb-xxx" \
  --slack-app-token "xapp-xxx"

openclaw gateway restart
```

### Step 5: Verify Installation

```bash
# Check status
openclaw status

# Test main agent
openclaw sessions send main "ping"

# Verify all agents
openclaw agents list
```

---

## 📊 Architecture

```
┌─────────────────────────────────────────────────────────┐
│  CAPITAL (中枢) - Central Hub                           │
│  ├─ main (CoS) - User Interface                         │
│  ├─ Three Departments:                                  │
│  │  ├─ policy-draft (中书省) - Policy Drafting         │
│  │  ├─ policy-review (门下省) - Policy Review          │
│  │  └─ execution (尚书省) - Project Management         │
│  └─ Six Ministries:                                     │
│     ├─ resources (户部) - Resources & Cost             │
│     ├─ engineering (工部) - Development                │
│     ├─ operations (刑部) - System Operations           │
│     ├─ security (兵部) - Security & Audit              │
│     ├─ knowledge (礼部) - Knowledge & Research         │
│     └─ people (吏部) - Performance & Training          │
└─────────────────────────────────────────────────────────┘
                            │ GitHub / API
                            ↓
┌─────────────────────────────────────────────────────────┐
│  REGIONAL (地方) - Project Servers                      │
│  ├─ Governor (州牧) - Project Manager                   │
│  └─ Local Six Ministries (地方六部)                     │
│     - Execute tasks locally                             │
│     - Report to Capital                                 │
└─────────────────────────────────────────────────────────┘
```

---

## ⚙️ Configuration Options

### Environment Variables

```bash
# Required
export AG_GOVERNMENT_MODE=capital  # or regional
export AG_SLACK_BOT_TOKEN=xoxb-xxx
export AG_SLACK_APP_TOKEN=xapp-xxx

# Optional
export AG_THREADS_MIN=2
export AG_THREADS_MAX=8
export AG_SCHEDULING_IDLE_THRESHOLD=30m
export AG_CAPITAL_HOST=https://capital.example.com
```

### Configuration Files

| File | Purpose |
|------|---------|
| `~/.openclaw/openclaw.json` | Main OpenClaw config |
| `~/.openclaw/config/mode` | Capital/Regional mode |
| `~/.openclaw/config/threads` | Thread limits |
| `~/.openclaw/config/scheduling` | Auto-scheduling config |

---

## 🎯 Quick Start

### 1. Create Your First Project

```bash
# On Capital
mkdir -p ~/.openclaw/projects/my-app
cd ~/.openclaw/projects/my-app

# Initialize project
cp -r ~/.openclaw/ai-government/templates/projects/web-platform/* .
```

### 2. Deploy to Regional Server

```bash
# On Regional server
curl -fsSL .../install.sh | bash -s -- --regional \
  --capital-host "https://your-capital.com" \
  --project "my-app"
```

### 3. Start Working

In Slack:
```
#main
You: I need a user authentication system
main(CoS): Received. Forwarding to policy layer.
  → Creates thread in #policy

#policy
policy-draft: 【Policy Draft】Auth System
  Objective: Build auth with login/register
  Timeline: 2 weeks
  → @policy-review please review

policy-review: Approved. Forwarding to execution.
  → @execution

#execution
execution: 【Execution Plan】
  M1: Login module → @engineering
  M2: Register module → @engineering
  Security audit → @security
  → Creates tasks

#engineering
engineering: Working on M1...
  → Delegates to regional via GitHub
```

---

## 📚 Documentation

- [Architecture Overview](docs/ARCHITECTURE.md)
- [A2A Protocol](shared/A2A_PROTOCOL.md) - Agent-to-Agent collaboration
- [System Rules](shared/SYSTEM_RULES.md) - Global guidelines
- [Task Protocol](shared/TASK_PROTOCOL.md) - Task management
- [Subagent Template](shared/SUBAGENT_PACKET_TEMPLATE.md) - Spawn tasks

---

## 🛠️ Troubleshooting

### Installation Fails

```bash
# Check prerequisites
which openclaw || npm install -g openclaw
which git || apt-get install git

# Re-run with debug
curl -fsSL .../install.sh | bash -s -- --capital --debug
```

### Agent Not Responding

```bash
# Check gateway status
openclaw gateway status

# Restart gateway
openclaw gateway restart

# Check logs
openclaw logs --follow
```

### Slack Connection Issues

```bash
# Verify tokens
curl -H "Authorization: Bearer $TOKEN" \
  https://slack.com/api/auth.test

# Reconfigure
openclaw channels remove slack
openclaw channels add --channel slack \
  --slack-bot-token "xoxb-xxx" \
  --slack-app-token "xapp-xxx"
```

---

## 🤝 Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## 📝 License

MIT License - Acknowledgments to [OpenCrew](https://github.com/AlexAnys/opencrew) for the foundation.

---

*Built with ❤️ extending OpenCrew's vision*