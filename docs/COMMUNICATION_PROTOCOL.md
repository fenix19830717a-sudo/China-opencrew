# 沟通协议 (Communication Protocol)

## 上报机制

### 1. 用户沟通 (You ↔ Agent)
**渠道**: Telegram
**配置**: ~/.openclaw/openclaw.json → channels.telegram
**用途**: 
- 接收用户指令
- 汇报任务完成
- 紧急通知

### 2. Agent-to-Agent 沟通 (Internal)
**渠道**: 本地共享知识库
**路径**: ~/.openclaw/shared/
**文件**:
- `inbox/` - 待处理消息
- `outbox/` - 已发送消息  
- `archive/` - 归档记录

**格式**:
```json
{
  "from": "agent-id",
  "to": "agent-id",
  "type": "task|response|notify",
  "content": "...",
  "timestamp": "2026-03-03T10:00:00Z",
  "priority": "high|normal|low"
}
```

### 3. 地方-中央沟通 (Regional ↔ Central)
**渠道**: GitHub 共享知识库
**仓库**: https://github.com/fenix19830717a-sudo/China-opencrew
**路径**: `/shared/governance/`

**同步机制**:
- 地方写入 → commit → push
- 中央读取 → pull → 处理
- 中央回复 → commit → push
- 地方读取 → pull → 执行

**文件结构**:
```
/shared/governance/
├── inbox/           # 来自地方的报告
│   └── YYYY-MM-DD/
├── outbox/          # 发给地方的指令
│   └── YYYY-MM-DD/
├── decisions/       # 决策记录
├── reports/         # 定期报告
└── sync.log         # 同步日志
```

## 消息类型

| 类型 | 说明 | 流向 |
|------|------|------|
| **指令** | 用户任务 | 用户 → Agent |
| **任务** | 派发给下属 | Agent → Agent |
| **报告** | 进度汇报 | Agent → 用户 |
| **决策** | 审批结果 | 中央 ↔ 地方 |

## 优先级

| 级别 | 响应时间 | 通知方式 |
|------|----------|----------|
| P0 - 紧急 | 立即 | Telegram + 本地 |
| P1 - 重要 | 1小时 | Telegram |
| P2 - 普通 | 当日 | 本地知识库 |
| P3 - 低优 | 排期 | GitHub |
