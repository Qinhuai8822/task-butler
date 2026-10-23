# Changelog

All notable changes to this project are documented in this file.
Format: keep a changelog (https://keepachangelog.com), semver versioning.

## [1.1.0] - 2026-10-23

### Added
- CREDITS.md: full methodology attribution — every stage and mode traced
  to its source article/author (Felix Rieseberg, Anthropic/OpenAI official
  guides, Simon Willison, Ethan Mollick, Michael Feathers, Michael Nygard,
  Locke & Latham goal-setting research, CMU LLM best practices).
- Per-mode "Sources" sections in all 6 modes; README credits expanded
  (bilingual) with explicit no-affiliation disclaimer.

## [1.0.0] - 2026-10-23

### Added
- CORE.md: six-stage task engine (Clarify -> Grill -> Plan -> Execute ->
  Verify externally -> Archive), industry-agnostic, tool-agnostic.
- modes/: 6 optional task-mode plugins — plan-grill (design-tree grilling),
  exec-tdd (test-driven execution), exec-heal (self-healing loop),
  verify-outside (external verification), write-edit (AI as editor),
  archive (three-layer archiving).
- profiles/: 4 platform adapters — generic (any AI), claude (CLAUDE.md),
  chatgpt (Custom Instructions), cli-agents (AGENTS.md).
- deploy/: one-command idempotent installers for Windows (PowerShell) and
  macOS/Linux (bash), with uninstall support.
- Methodology distilled from public best practices: Felix Rieseberg's
  "How to be more ambitious" essay, Anthropic/OpenAI official prompting
  guides, Simon Willison's editor-not-author writing workflow.
- Deliberately excluded: any industry-specific knowledge, any private-skill
  dependency, any account binding, any personal context.
