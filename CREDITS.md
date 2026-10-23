# Credits & Sources — 方法论来源

Task Butler 不发明新理论——它把一批公开、经过实战检验的 AI 使用方法论，
蒸馏成一套可移植的提示词系统。以下每一阶段、每一模式都能追溯到具体来源。
向所有原作者致敬；如有遗漏或偏差，欢迎提 issue。

## 核心来源（CORE 六阶段引擎）

| 来源 | 作者 | 链接 | 贡献了什么 |
|------|------|------|------------|
| How to be more ambitious: A tutorial for humans with models (2026-10-13) | **Felix Rieseberg**（Anthropic，Claude/Cowork/Code Desktop 工程负责人） | https://felixrieseberg.com/how-to-be-more-ambitious-a-tutorial-for-humans-with-models/ | 阶段 0"目标上移"（Altitude）；阶段 3 升级判据（专家工具/原始数据/激进目标/红队）；阶段 4 铁律"别让模型自评"（outside judge）；复盘沉淀 |
| Made by Mechanical Means (2026-09-27) | Felix Rieseberg | https://felixrieseberg.com/made-by-mechanical-means/ | "只谈目标、由 AI 编排执行"的多智能体工作流实证 |
| Claude Code: Best Practices for Agentic Coding | Anthropic 工程团队 | https://www.anthropic.com/engineering/claude-code-best-practices | 探索式/计划式双模式、项目记忆文件、长任务上下文管理 |
| Prompt Engineering Overview & Interactive Tutorial | Anthropic | https://docs.claude.com/en/docs/build-with-claude/prompt-engineering/overview | 角色设定、清晰约束（"不要…因为…"）、成功标准前置 |
| A Practical Guide to Prompting Agents (GPT-5 Prompting Guide) | OpenAI | https://cookbook.openai.com/examples/gpt-5/gpt-5_prompting_guide | 明确约束+原因、可验证的成功标准、权限最小化 |
| Goal-setting theory（35 年目标设定研究综述） | Edwin Locke & Gary Latham | 经由 Felix 文章引用 | "具体而困难的目标优于'尽力而为'"——阶段 3 激进目标的实证依据 |

## 模式来源（modes/）

| 模式 | 主要来源 | 作者 | 链接 |
|------|----------|------|------|
| plan-grill.md | 设计树拷问法（frontier 轮次推进、事实自查/决策问人） | Felix Rieseberg 同期分享的 grilling 方法论 | https://felixrieseberg.com/ |
| exec-tdd.md | 红-绿-重构循环；seam（测试接缝）概念 | Michael Feathers《Working Effectively with Legacy Code》；Kent Beck《TDD by Example》 | https://www.goodreads.com/book/show/38360361-working-effectively-with-legacy-code |
| exec-heal.md | 自愈循环：退避重试、熔断、失败分类 | 分布式系统容错通用实践（circuit breaker 模式；Microsoft Azure 架构指南） | https://learn.microsoft.com/en-us/azure/architecture/patterns/circuit-breaker |
| verify-outside.md | "外部裁判"原则；AI 是编辑不是作者 | Felix Rieseberg；Simon Willison | https://simonwillison.net/ |
| write-edit.md | "AI 是编辑，不是作者"：禁止鼓励、禁止代笔、禁止编造 | Simon Willison | https://simonwillison.net/tags/prompt-engineering/ |
| archive.md | ADR（架构决策记录）实践；三层归档 | Michael Nygard《Documenting Architecture Decisions》 | https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions |

## 人机协作观念来源

| 来源 | 作者 | 链接 | 贡献了什么 |
|------|------|------|------------|
| Co-Intelligence: Living and Working with AI；《One Useful Thing》 | Ethan Mollick（宾夕法尼亚大学沃顿商学院） | https://www.oneusefulthing.org/ | "AI 是队友不是工具"；锯齿状能力边界须亲自试探 |
| Simon Willison's Weblog | Simon Willison（Django 联合创造者） | https://simonwillison.net/ | 上下文管理是核心技能；对模型能力边界的实战观察 |
| AI 工作流系列 | Addy Osmani（Google Chrome 工程负责人） | https://addyosmani.com/ | "AI 是放大器"：人的判断决定输出上限 |
| Best Practices for Large Language Models | CMU Libraries（汇编 Simon Willison / Gavin Leech 等） | https://guides.library.cmu.edu/LLM_best_practices | "过度自信但飞快的结对助手"角色定位 |

## 声明

- Task Butler 是独立的开源蒸馏项目，与上表作者及其机构（Anthropic、
  OpenAI、CMU 等）**无官方隶属或背书关系**；引用仅为学术致敬与溯源。
- 如原作者不愿被引用，或来源标注有误，请提 issue，我们会立即修正。
- 本项目以 MIT 协议发布，欢迎 fork、改编与再蒸馏。
