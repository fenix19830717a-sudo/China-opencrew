# Slack 兼容方案

## 方案概述

AI Government 架构同时支持两种沟通模式：
- **默认模式**：本地知识库 + GitHub（去中心化，推荐）
- **Slack模式**：Slack频道（中心化，兼容OpenCrew）

## 架构对比

### 默认模式（知识库模式）

```
用户 → 大内总管 → 中书省 → 门下省 → 尚书省 → 六部
                ↓
              本地知识库（~/.openclaw/shared/）
```

**优点**：
- 去中心化，不依赖外部服务
- 所有沟通记录本地保存
- 适合离线/内网环境

**缺点**：
- 需要定期同步
- 实时性稍差

### Slack模式（频道模式）

```
#palace    → 大内总管
#policy    → 中书省 + 门下省
#execution → 尚书省
#revenue   → 户部
#works     → 工部
#justice   → 刑部
#war       → 兵部
#rites     → 礼部
#personnel → 吏部
```

**优点**：
- 实时沟通，响应快
- 可视化管理
- 符合OpenCrew习惯

**缺点**：
- 依赖Slack服务
- 需要网络连接

---

## Slack频道设计

### 中央频道（必选）

| 频道 | 对应Agent | 用途 |
|------|----------|------|
| `#palace` | 大内总管 | 用户接口，接收指令，汇报奏折 |
| `#policy` | 中书省+门下省 | 国策起草、审核、讨论 |
| `#execution` | 尚书省 | 任务分解、进度跟踪、项目管理 |

### 六部频道（可选，按需启用）

| 频道 | 对应Agent | 用途 |
|------|----------|------|
| `#revenue` | 户部 | 资源统计、成本讨论 |
| `#works` | 工部 | 技术方案、代码审查 |
| `#justice` | 刑部 | 运维监控、故障处理 |
| `#war` | 兵部 | 安全审查、对外操作 |
| `#rites` | 礼部 | 知识管理、文档讨论 |
| `#personnel` | 吏部 | 考核培训、人事讨论 |

### 地方频道（按项目创建）

| 频道模板 | 用途 |
|----------|------|
| `#project-{name}` | 州牧管理该项目所有环境 |
| `#project-{name}-{env}` | 特定环境的讨论 |

---

## 两种模式共存

### 混合模式（推荐）

**中央层使用Slack**：
- 大内总管、中书省、门下省、尚书省
- 实时沟通，快速响应

**执行层使用本地知识库**：
- 六部日常工作
- 地方项目执行
- 定期同步到Slack汇报

### 数据同步机制

```
Slack（中央层）
    ↕ 双向同步
本地知识库（执行层）
    ↕ 定期同步
GitHub（中央-地方）
```

**同步规则**：
1. **决策层**（三省+尚书省）：Slack实时
2. **执行层**（六部）：本地知识库为主，Slack摘要
3. **地方层**：GitHub异步，定期Slack汇报

---

## OpenClaw配置

### 配置片段（Slack模式）

```json
{
  "agents": {
    "list": [
      {
        "id": "steward",
        "name": "大内总管",
        "workspace": "~/.openclaw/central/steward",
        "subagents": {"allowAgents": ["steward"]}
      },
      {
        "id": "chancellery",
        "name": "中书省",
        "workspace": "~/.openclaw/central/chancellery",
        "subagents": {"allowAgents": ["chancellery", "inspectorate"]}
      }
      // ... 其他Agent
    ]
  },
  
  "bindings": [
    // 大内总管 - #palace频道
    {
      "agentId": "steward",
      "match": {
        "channel": "slack",
        "peer": {"kind": "channel", "id": "PALACE_CHANNEL_ID"}
      }
    },
    // 中书省+门下省 - #policy频道
    {
      "agentId": "chancellery",
      "match": {
        "channel": "slack",
        "peer": {"kind": "channel", "id": "POLICY_CHANNEL_ID"}
      }
    },
    {
      "agentId": "inspectorate",
      "match": {
        "channel": "slack",
        "peer": {"kind": "channel", "id": "POLICY_CHANNEL_ID"}
      }
    },
    // 尚书省 - #execution频道
    {
      "agentId": "state",
      "match": {
        "channel": "slack",
        "peer": {"kind": "channel", "id": "EXECUTION_CHANNEL_ID"}
      }
    }
    // ... 六部绑定
  ],
  
  "channels": {
    "slack": {
      "channels": {
        "PALACE_CHANNEL_ID": {"allow": true, "requireMention": false},
        "POLICY_CHANNEL_ID": {"allow": true, "requireMention": false},
        "EXECUTION_CHANNEL_ID": {"allow": true, "requireMention": false}
        // ... 其他频道
      }
    }
  }
}
```

---

## 迁移指南（从OpenCrew）

### OpenCrew → AI Government 映射

| OpenCrew | AI Government | Slack频道 |
|----------|---------------|-----------|
| cos | steward（大内总管） | #palace |
| cto | works（工部） | #works |
| builder | 地方工部 | 项目频道 |
| research | rites（礼部） | #rites |
| ko | rites（礼部） | #rites |
| ops | justice（刑部） | #justice |
| - | chancellery（中书省） | #policy |
| - | inspectorate（门下省） | #policy |
| - | state（尚书省） | #execution |
| - | war（兵部） | #war |
| - | revenue（户部） | #revenue |
| - | personnel（吏部） | #personnel |

### 迁移步骤

1. **保留现有Slack频道**
   - #hq → #palace（大内总管）
   - #cto → #works（工部）
   - #build → 项目频道（地方工部）
   - 其他频道按需调整

2. **新增频道**
   - #policy：中书省+门下省
   - #execution：尚书省
   - #war：兵部（安全）
   - #revenue：户部（资源）
   - #personnel：吏部（考核）

3. **配置Agent绑定**
   - 按上述配置更新openclaw.json
   - 重启Gateway

4. **试运行**
   - 先在新项目试用
   - 逐步迁移现有项目

---

## 推荐配置

### 小型团队（3-5人）

**Slack频道**：
- #palace（必需）
- #policy（必需）
- #execution（必需）
- #general（六部共用，可选）

**模式**：纯Slack模式

### 中型团队（10-20人）

**Slack频道**：
- #palace
- #policy
- #execution
- #works（技术开发）
- #war（安全）
- #justice（运维）

**模式**：Slack + 本地知识库混合

### 大型团队（20+人）

**Slack频道**：
- 所有中央频道
- 六部独立频道
- 各项目独立频道

**模式**：Slack（中央）+ 本地知识库（六部）+ GitHub（地方）

---

## 总结

| 模式 | 适用场景 | 配置复杂度 | 推荐度 |
|------|----------|-----------|--------|
| 纯本地 | 离线/内网 | 低 | ⭐⭐⭐ |
| 纯Slack | 小型团队 | 中 | ⭐⭐⭐⭐ |
| **混合** | **中大型团队** | **中** | **⭐⭐⭐⭐⭐** |

**默认推荐**：中央层Slack + 执行层本地知识库 + 地方GitHub

这样既保留了Slack的实时性和可视化，又保持了架构的去中心化优势。
