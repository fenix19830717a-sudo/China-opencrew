# 命名规范 - 中英文对照

## 设计原则

1. **英文名称体现职能**：不看中文也能懂是做什么的
2. **保留历史渊源**：中文注释说明唐朝对应官职
3. **简洁明了**：避免过长，便于日常使用

---

## 中央层（Central）

| 新英文ID | 英文名称 | 中文 | 唐朝对应 | 核心职能 |
|----------|----------|------|----------|----------|
| **steward** | **ChiefSteward** | 大内总管 | 太监总管 | 用户接口、指令分发 |
| **policy** | **PolicyDraft** | 中书省 | 中书令 | 政策起草、需求澄清 |
| **review** | **PolicyReview** | 门下省 | 侍中 | 政策审核、质量控制 |
| **exec** | **Execution** | 尚书省 | 尚书令 | 项目管理、任务分解 |

---

## 六部（Ministries）

| 新英文ID | 英文名称 | 中文 | 唐朝对应 | 核心职能 |
|----------|----------|------|----------|----------|
| **resources** | **Resources** | 户部 | 户部尚书 | 资源管理、成本核算、预测 |
| **engineering** | **Engineering** | 工部 | 工部尚书 | 技术开发、架构设计 |
| **operations** | **Operations** | 刑部 | 刑部尚书 | 系统运维、监控 |
| **security** | **Security** | 兵部 | 兵部尚书 | 安全审查、对外操作、审计 |
| **knowledge** | **Knowledge** | 礼部 | 礼部尚书 | 知识管理、Research、培训 |
| **people** | **People** | 吏部 | 吏部尚书 | 绩效考核、培训发展、质量审计 |

---

## 地方层（Regional）

| 英文ID | 英文名称 | 中文 | 职能 |
|--------|----------|------|------|
| **governor** | **Governor** | 州牧 | 项目负责人、本地管理 |
| **local-resources** | **LocalResources** | 地方户部 | 本地资源管理 |
| **local-engineering** | **LocalEngineering** | 地方工部 | 本地开发执行 |
| **local-operations** | **LocalOperations** | 地方刑部 | 本地运维 |
| **local-security** | **LocalSecurity** | 地方兵部 | 本地安全 |
| **local-knowledge** | **LocalKnowledge** | 地方礼部 | 本地知识 |
| **local-people** | **LocalPeople** | 地方吏部 | 本地考核 |

---

## 旧命名 vs 新命名对比

### 问题示例

| 旧命名 | 问题 | 新命名 | 改进 |
|--------|------|--------|------|
| chancellery | 不认识这个单词 | **PolicyDraft** | 一看就知道是起草政策 |
| inspectorate | 生僻词 | **PolicyReview** | 审核政策，清晰明了 |
| state | 歧义（国家/状态） | **Execution** | 执行任务 |
| works | 歧义（作品/工作） | **Engineering** | 工程技术 |
| justice | 歧义（正义/司法） | **Operations** | 运维操作 |
| war | 太夸张（战争） | **Security** | 安全保护 |
| rites | 生僻（仪式） | **Knowledge** | 知识管理 |
| revenue | 狭窄（收入） | **Resources** | 资源管理 |
| personnel | 过时（人事） | **People** | 人员发展 |

---

## 快速记忆法

```
中央决策层：
- ChiefSteward（大管家）→ 对接用户
- PolicyDraft（起草）→ 写方案
- PolicyReview（审核）→ 把关质量
- Execution（执行）→ 管项目

六部执行层：
- Resources（资源）→ 管钱管资源
- Engineering（工程）→ 写代码
- Operations（运维）→ 保稳定
- Security（安全）→ 防攻击
- Knowledge（知识）→ 管文档
- People（人员）→ 管考核
```

---

## 使用示例

### 文件路径

```
workspaces/
├── chief-steward/          # 大内总管
├── policy-draft/           # 中书省
├── policy-review/          # 门下省
├── execution/              # 尚书省
├── resources/              # 户部
├── engineering/            # 工部
├── operations/             # 刑部
├── security/               # 兵部
├── knowledge/              # 礼部
└── people/                 # 吏部
```

### Slack频道

```
#chief-steward     → 大内总管
#policy-draft      → 政策起草
#policy-review     → 政策审核
#execution         → 执行管理
#resources         → 资源管理
#engineering       → 技术开发
#operations        → 运维监控
#security          → 安全审查
#knowledge         → 知识管理
#people            → 人员考核
```

### 配置示例

```json
{
  "agents": {
    "list": [
      {
        "id": "chief-steward",
        "name": "Chief Steward",
        "role": "User interface and command dispatch",
        "tangDynasty": "Grand Chancellor"
      },
      {
        "id": "policy-draft", 
        "name": "Policy Draft",
        "role": "Policy drafting and requirement clarification",
        "tangDynasty": "Chancellery"
      },
      {
        "id": "engineering",
        "name": "Engineering",
        "role": "Technical development and architecture",
        "tangDynasty": "Ministry of Works"
      }
    ]
  }
}
```

---

## 完整映射表

| 层级 | 新ID | 英文名称 | 中文 | 唐朝 | 一句话说明 |
|------|------|----------|------|------|-----------|
| 用户接口 | chief-steward | Chief Steward | 大内总管 | 太监总管 | 用户唯一接口 |
| 决策起草 | policy-draft | Policy Draft | 中书省 | 中书令 | 起草宏观政策 |
| 决策审核 | policy-review | Policy Review | 门下省 | 侍中 | 审核政策质量 |
| 项目管理 | execution | Execution | 尚书省 | 尚书令 | 分解执行任务 |
| 资源财务 | resources | Resources | 户部 | 户部尚书 | 管钱管资源 |
| 技术开发 | engineering | Engineering | 工部 | 工部尚书 | 写代码做架构 |
| 运维监控 | operations | Operations | 刑部 | 刑部尚书 | 保系统稳定 |
| 安全审计 | security | Security | 兵部 | 兵部尚书 | 防攻击做审计 |
| 知识研究 | knowledge | Knowledge | 礼部 | 礼部尚书 | 管文档做研究 |
| 考核培训 | people | People | 吏部 | 吏部尚书 | 管考核做培训 |

---

## 迁移说明

如果使用旧命名的配置，可以通过别名兼容：

```json
{
  "agentAliases": {
    "steward": "chief-steward",
    "chancellery": "policy-draft",
    "inspectorate": "policy-review",
    "state": "execution",
    "works": "engineering",
    "justice": "operations",
    "war": "security",
    "rites": "knowledge",
    "revenue": "resources",
    "personnel": "people"
  }
}
```
