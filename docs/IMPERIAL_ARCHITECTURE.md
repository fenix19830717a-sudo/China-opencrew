# AI Government - 智能体政府架构

> 基于 OpenCrew 的三省六部制 AI Team 架构

## 架构概览

### 紫禁城 (Forbidden City) - 个人层
- **大内总管**: 指令分类、生活事务处理
- **私人收藏库**: API Keys、密码配置

### 行政中枢 (Central Government) - 执行层
#### 三省 (Three Departments)
- **中书省 (Chancellery)**: 决策起草、三问三答
- **门下省 (Inspectorate)**: 审核政令、风险评估  
- **尚书省 (State Affairs)**: 执行调度、跨部协调

#### 六部 (Six Ministries)
- **户部 (Revenue)**: 资源报表、成本核算
- **工部 (Works)**: 项目管理、委托实施
- **刑部 (Justice)**: 运维监控、故障排查
- **兵部 (War)**: 安全审查、权限控制
- **礼部 (Rites)**: 知识库、文档维护
- **吏部 (Personnel)**: KPI管理、绩效评估

### 地方 (Regional) - 分布式
- 专项子Agent
- 独立项目 (FLOB2B, STD独立站等)

## 核心设计原则

1. **自洽运行**: Sub-Agent 闭环体系
2. **分布式协作**: 多 OpenClaw 实例通信
3. **项目拆分**: 爆炸上下文 → 细分任务
4. **主线支线**: 知识库同步 + 定期合并
5. **多项目并行**: 优先级调度
6. **自动运行**: Cron + Heartbeat

## Slack 频道

- #palace-internal (紫禁城)
- #chancellery (中书省)
- #inspectorate (门下省)
- #state-affairs (尚书省)
- #revenue, #works, #justice, #war, #rites, #personnel (六部)
- #regional-gov (地方)

## 工作流程

### 标准流程
用户 → 大内总管 → 中书省 → 门下省 → 尚书省 → 六部 → 知识库 → 用户

### 紧急流程
用户 → 大内总管(标记紧急) → 尚书省(直接执行) → 事后补文档
