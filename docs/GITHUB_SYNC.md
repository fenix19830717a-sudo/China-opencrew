# GitHub 同步指南

## 架构
```
Capital (首都)                    Regional (地方/kimiclaw/工作电脑)
    │                                    │
    ├── 创建任务 ──→ GitHub ──→ 地方拉取任务
    │                                    │
    │←── 查看结果 ←── GitHub ←── 提交结果
    │                                    │
```

## 首都 (Capital) 操作流程

### 1. 创建任务
```bash
cd ~/.openclaw/ai-government

# 创建新任务
echo "# TASK-XXX" > tasks/pending/TASK-XXX-agent.md

# 提交
git add tasks/
git commit -m "task: Add TASK-XXX for agent"
git push origin main
```

### 2. 查看结果
```bash
# 拉取地方提交的结果
./sync.sh pull

# 查看完成的任务
cat tasks/completed/TASK-XXX-agent.md
```

## 地方 (Regional) 操作流程

### 1. 拉取任务
```bash
cd ~/.openclaw/ai-government

# 拉取最新任务
./sync.sh pull

# 查看待办任务
ls tasks/pending/
```

### 2. 认领任务
```bash
# 将任务移动到active
mv tasks/pending/TASK-XXX-agent.md tasks/active/

# 开始执行...
```

### 3. 提交结果
```bash
# 编辑任务文件，添加结果
vim tasks/active/TASK-XXX-agent.md

# 移动到completed
mv tasks/active/TASK-XXX-agent.md tasks/completed/

# 推送
./sync.sh push
```

## 自动同步 (Cron)

### 首都 - 每5分钟检查新结果
```bash
*/5 * * * * ~/.openclaw/ai-government/sync.sh pull >> ~/.openclaw/sync.log 2>&1
```

### 地方 - 每5分钟检查新任务
```bash
*/5 * * * * ~/.openclaw/ai-government/sync.sh pull >> ~/.openclaw/sync.log 2>&1
```

## 任务状态流转

```
tasks/pending/     →  待认领
tasks/active/      →  执行中  
tasks/completed/   →  已完成
```

## 冲突处理

如果git pull失败：
```bash
cd ~/.openclaw/ai-government
git stash
git pull origin main
git stash pop
# 手动解决冲突
```

## 当前任务状态

查看任务板：
```bash
cat ~/.openclaw/ai-government/tasks/README.md
```
