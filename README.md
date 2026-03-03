# AI Government - Intelligent Agent Governance Framework

> A multi-project, multi-environment AI agent collaboration system based on Tang Dynasty's Three Departments and Six Ministries architecture.

[中文](#中文说明) | [English](#english-description)

---

## Quick Start

### Naming Convention (New!)

We use **functional English names** that clearly describe what each agent does:

| English ID | Name | Chinese | Function |
|------------|------|---------|----------|
| chief-steward | **Chief Steward** | 大内总管 | User interface |
| policy-draft | **Policy Draft** | 中书省 | Policy drafting |
| policy-review | **Policy Review** | 门下省 | Quality review |
| execution | **Execution** | 尚书省 | Project management |
| resources | **Resources** | 户部 | Resource & cost |
| engineering | **Engineering** | 工部 | Development |
| operations | **Operations** | 刑部 | System operations |
| security | **Security** | 兵部 | Security & audit |
| knowledge | **Knowledge** | 礼部 | Knowledge & research |
| people | **People** | 吏部 | Performance & training |

**Why these names?** See [Naming Convention](docs/NAMING_CONVENTION.md)

---

## Architecture Overview

```
User
  ↕
Chief Steward (User Interface)
  ↕
Policy Draft (Draft policies) → Policy Review (Review policies)
  ↕
Execution (Project Management)
  ↕
Six Ministries
├── Resources (Resource management)
├── Engineering (Development)
├── Operations (System ops)
├── Security (Security & audit)
├── Knowledge (Knowledge & research)
└── People (Performance & training)
```

---

## Core Features

### Multi-Project × Multi-Environment

Support N projects × M environments:
- **Project Level**: Governor manages multiple environments per project
- **Environment Level**: Local ministries execute in specific environment
- **Flexible**: Any project can deploy to any environment

### Two Communication Modes

1. **Knowledge Base Mode** (Default): Decentralized, no external dependency
2. **Slack Mode** (Compatible): Real-time, visual management
3. **Hybrid Mode** (Recommended): Slack for central, knowledge base for execution

See [Slack Compatibility](docs/SLACK_COMPATIBILITY.md)

---

## Documentation

- [Architecture Design](docs/ARCHITECTURE.md)
- [Naming Convention](docs/NAMING_CONVENTION.md) ⭐ New!
- [Slack Compatibility](docs/SLACK_COMPATIBILITY.md)
- [Workload Simulation](docs/WORKLOAD_SIMULATION.md)
- [OpenCrew Comparison](docs/COMPARISON.md)

---

## Project Structure

```
aigovernment/
├── central/                    # Central layer (global management)
│   ├── chief-steward/         # User interface
│   ├── policy-draft/          # Policy drafting
│   ├── policy-review/         # Policy review
│   ├── execution/             # Project management
│   └── ministries/            # Six ministries
│       ├── resources/         # Resource & cost
│       ├── engineering/       # Development
│       ├── operations/        # System operations
│       ├── security/          # Security & audit
│       ├── knowledge/         # Knowledge & research
│       └── people/            # Performance & training
│
├── templates/                  # Templates for projects & environments
│   ├── projects/              # Project templates
│   └── regions/               # Environment templates
│
└── docs/                       # Documentation
```

---

##中文说明

## 命名规范（新！）

我们使用**职能导向的英文名称**，一看就知道是做什么的：

| 英文ID | 英文名称 | 中文 | 核心职能 |
|--------|----------|------|----------|
| chief-steward | **Chief Steward** | 大内总管 | 用户接口 |
| policy-draft | **Policy Draft** | 中书省 | 政策起草 |
| policy-review | **Policy Review** | 门下省 | 质量审核 |
| execution | **Execution** | 尚书省 | 项目管理 |
| resources | **Resources** | 户部 | 资源成本 |
| engineering | **Engineering** | 工部 | 技术开发 |
| operations | **Operations** | 刑部 | 系统运维 |
| security | **Security** | 兵部 | 安全审计 |
| knowledge | **Knowledge** | 礼部 | 知识研究 |
| people | **People** | 吏部 | 考核培训 |

**为什么用这些名称？** 参见 [命名规范](docs/NAMING_CONVENTION.md)

---

## 核心特性

### 多项目 × 多环境

支持 N项目 × M环境 灵活组合：
- **项目层**：州牧管理每个项目的多个环境
- **环境层**：地方六部在具体环境执行
- **灵活**：任何项目可部署到任何环境

### 两种沟通模式

1. **知识库模式**（默认）：去中心化，不依赖外部服务
2. **Slack模式**（兼容）：实时可视化
3. **混合模式**（推荐）：中央Slack + 执行层知识库 + 地方GitHub

参见 [Slack兼容方案](docs/SLACK_COMPATIBILITY.md)

---

## 文档导航

- [架构设计](docs/ARCHITECTURE.md)
- [命名规范](docs/NAMING_CONVENTION.md) ⭐ 新！
- [Slack兼容方案](docs/SLACK_COMPATIBILITY.md)
- [工作量模拟](docs/WORKLOAD_SIMULATION.md)
- [OpenCrew对比](docs/COMPARISON.md)
