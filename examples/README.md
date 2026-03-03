# 示例目录

此目录用于存放使用 AI Government 架构的具体项目示例。

**注意**: 公开仓库中不包含具体的项目配置，只提供示例结构参考。

## 使用方式

1. 基于 `templates/projects/` 中的模板创建你的项目
2. 基于 `templates/regions/` 中的模板创建你的部署环境
3. 在此目录下初始化你的具体项目配置

## 示例结构

```
examples/
├── project-a/              # 你的项目A
│   ├── prod-env/          # 生产环境部署
│   └── staging-env/       # 测试环境部署
│
└── project-b/              # 你的项目B
    └── ...
```

## 快速开始

```bash
# 1. 复制项目模板
cp -r templates/projects/web-platform examples/my-project

# 2. 复制环境模板
cp -r templates/regions/cloud-ali examples/my-project/prod-env

# 3. 配置环境参数
# 编辑 examples/my-project/prod-env/config.yaml

# 4. 初始化
cd examples/my-project
./init.sh
```
