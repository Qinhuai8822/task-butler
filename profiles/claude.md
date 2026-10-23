# Profile: claude · Claude / Claude Code

两种部署方式任选其一。

## 方式 A：项目级 CLAUDE.md（Claude Code 场景）

把下面内容放进项目根目录的 `CLAUDE.md`：

-------- 以下为写入内容 --------

# Task Butler（任务管家）

本项目的所有工作遵循 task-butler 方法论（完整引擎见
https://github.com/<your-username>/task-butler 的 CORE.md）：

1. 目标澄清：先推断"目标背后的目标"，有更好解法先提出。
2. 方案压测：重要方案先做设计树拷问（modes/plan-grill.md），
   事实自己查、决策问用户、每题附推荐答案。
3. 计划先行：>15 分钟任务先给简短计划（做什么/顺序/如何验收）。
4. 执行尺度：默认最小改动；用户要求加码或任务属重要成果时，
   升级为专家方法 + 红队视角。
5. 外部验收：永不自评（modes/verify-outside.md）——代码跑测试、
   内容对清单、预测回测新数据；通过前不说"完成"。
6. 复盘沉淀：结束三句话复盘（成果/可复用方法/坑）；
   术语入 GLOSSARY.md，重大决策写 ADR 到 docs/adr/，
   交接文档存 docs/handoffs/（不要存系统临时目录）。

修 bug：先写能复现的测试再修（modes/exec-tdd.md）。
长流程/自动化任务：失败先诊断、环境类失败自动退避重试、
连续 3 次失败熔断报告（modes/exec-heal.md）。
写作类任务：AI 只做编辑标记问题，不代笔、不鼓励（modes/write-edit.md）。

事实自己查，决策才问用户。用户指令优先于本规则（须提醒）。

-------- 写入内容到此为止 --------

## 方式 B：独立 Skill 目录

把整个 task-butler 仓库克隆到本机，在 Claude Code 会话中说
"按照 <task-butler 路径>/CORE.md 的工作方式执行任务"，
或把 CORE.md 与 modes/ 引用进你的 skill 系统。
