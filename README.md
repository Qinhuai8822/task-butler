# Task Butler — 任务管家

**One prompt layer that makes any AI manage any task, in any industry, on any computer.**

任何行业 · 任何电脑 · 任何 AI · 任何任务方向——一段提示词层，让 AI 自动完成
目标澄清、方案压测、计划、执行、外部验收与复盘沉淀。你只管下任务。

[中文说明](#中文说明) | [English](#english)

---

## English

### What it is
A portable, industry-agnostic prompt system. Paste it once into any AI assistant
(Claude, ChatGPT, Gemini, Cursor, Codex, or any tool with a system prompt /
custom instructions box), and the AI automatically follows a six-stage task
engine: **Clarify → Grill → Plan → Execute → Verify (externally) → Archive**.

- **Any industry**: examples and rules are domain-neutral. Code, writing,
  analysis, design, research, operations — all covered.
- **Any AI**: pure markdown prompts. No plugins, no API keys, no tooling
  dependency. Modes degrade gracefully.
- **Any computer**: one-command deploy for Windows / macOS / Linux.
- **Extensible**: drop a new markdown file into `modes/` to teach the butler
  a new task pattern. No code changes needed.

### 30-second start
1. Open `profiles/generic.md`, copy everything.
2. Paste it into your AI assistant's "Custom Instructions / System Prompt /
   Memory" box.
3. Say: *"Help me do X."* The butler takes over.

Or use the installer:
```powershell
# Windows (default policy blocks .ps1 — bypass for this one command)
powershell -NoProfile -ExecutionPolicy Bypass -File .\deploy\deploy.ps1
```
```bash
# macOS / Linux
./deploy/deploy.sh
```
Installers are idempotent: re-running updates the block in place;
`-Target uninstall` (or menu option 5) removes it cleanly.

### Repository layout
```
task-butler/
├── CORE.md            # The single source of truth: six-stage engine
├── modes/             # Optional task-mode plugins
│   ├── plan-grill.md      # Interrogate plans with a design tree
│   ├── exec-tdd.md        # Test-driven execution (code tasks)
│   ├── exec-heal.md       # Self-healing loop (automation tasks)
│   ├── verify-outside.md  # External verification (never self-grade)
│   ├── write-edit.md      # "AI as editor, not author" (writing tasks)
│   └── archive.md         # Unified archiving & handoff rules
├── profiles/          # Platform adapters
│   ├── generic.md     # Any AI (paste into custom instructions)
│   ├── claude.md      # Claude / Claude Code (CLAUDE.md)
│   ├── chatgpt.md     # ChatGPT Custom Instructions
│   └── cli-agents.md  # Cursor / Codex / Cline / Gemini CLI (AGENTS.md)
├── deploy/            # One-command installers (ps1 / sh)
├── CHANGELOG.md
└── LICENSE            # MIT
```

### Extending
Add `modes/your-mode.md`:
```markdown
# Mode: your-mode
适用场景: ...
核心规则: ...
验收方式: ...
```
The core engine picks it up; nothing else changes.

### Credits
The methodology is distilled — with full attribution — from public,
battle-tested sources. Task Butler is an independent open-source project with
no official affiliation to the authors or their companies.

**Highlights**:
- [Felix Rieseberg](https://felixrieseberg.com/how-to-be-more-ambitious-a-tutorial-for-humans-with-models/) (Anthropic, engineering lead for Claude / Cowork / Code Desktop) — "How to be more ambitious": goal-behind-the-goal (altitude), expert depth, red-team range, and the "never let the model grade itself" rule.
- [Anthropic](https://www.anthropic.com/engineering/claude-code-best-practices) & [OpenAI](https://cookbook.openai.com/examples/gpt-5/gpt-5_prompting_guide) official engineering & prompting guides — plan-first agentic patterns, explicit constraints, verifiable success criteria.
- [Simon Willison](https://simonwillison.net/) — "AI as editor, not author" writing workflow.
- [Ethan Mollick](https://www.oneusefulthing.org/) (Wharton) — AI as teammate, jagged frontier.
- [Michael Feathers](https://www.goodreads.com/book/show/38360361-working-effectively-with-legacy-code) / [Michael Nygard](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions) — seams & ADRs.

Full source list with per-mode attribution: [CREDITS.md](CREDITS.md). MIT licensed.

---

## 中文说明

### 这是什么
一套可移植、行业无关的提示词系统。粘贴一次到任何 AI 助手的"自定义指令/
系统提示"里，AI 就自动按六阶段引擎工作：**澄清 → 压测 → 计划 → 执行 →
外部验收 → 沉淀**。你只管下任务，管家管流程。

- **任何行业**：示例与规则全部中性化，代码/写作/分析/设计/调研/运营通吃
- **任何 AI**：纯 markdown，无插件、无 API、无工具依赖
- **任何电脑**：Windows / macOS / Linux 一条命令部署
- **可扩展**：往 `modes/` 丢一个 md 文件即新增任务模式，核心零改动

### 30 秒上手
1. 打开 `profiles/generic.md`，全选复制
2. 粘贴到你的 AI 工具的"自定义指令 / 系统提示 / 记忆"框
3. 说"帮我做 X"，管家自动接管

或用安装脚本：`./deploy/deploy.ps1`（Windows）/ `./deploy/deploy.sh`（mac/Linux）

### 核心取舍（为什么轻）
本系统刻意不包含：任何行业专属知识、任何私有 skill 依赖、任何账号绑定。
专业性由你环境里已有的工具/技能承担，管家负责流程——事实自己查，
决策才问你，验收永远交给外部裁判。

### 设计来源
本系统不发明理论，只做蒸馏，全部来源在 [CREDITS.md](CREDITS.md) 逐条
可溯。重点致谢：
- **Felix Rieseberg**（Anthropic，Claude/Cowork/Code Desktop 工程负责人）
  《[How to be more ambitious](https://felixrieseberg.com/how-to-be-more-ambitious-a-tutorial-for-humans-with-models/)》：
  目标上移、专家深度、红队广度、"永远别让模型给自己打分"
- **Anthropic / OpenAI 官方工程与提示指南**：先计划后执行、明确约束、
  可验证的成功标准
- **Simon Willison**："AI 是编辑不是作者" 写作法
- **Ethan Mollick**（沃顿商学院）：AI 是队友、锯齿能力边界
- **Michael Feathers / Michael Nygard**：seam 测试接缝、ADR 决策记录

Task Butler 为独立开源蒸馏项目，与上述作者及其机构无官方隶属关系。
MIT 协议，欢迎 fork、改编与再蒸馏。
