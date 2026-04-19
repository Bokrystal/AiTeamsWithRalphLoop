# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repository contains documentation, system prompts, and template files for an AI-powered frontend development workflow based on the **Ralph Loop** (continuous iteration cycle). It supports two operational modes:

- **Multi‑agent collaborative mode**: Three specialized agents (Planner, Generator, Evaluator) work in a coordinated pipeline.
- **Single unified‑agent mode**: One agent executes the entire Ralph Loop with integrated multimodal verification (Figma + Playwright MCPs).

The workflow emphasizes **atomic feature development**, **automated visual/functional validation**, **circuit‑breaker mechanisms** to prevent dead loops, and **externalized memory** for cross‑session continuity.

## Key Files

| File | Purpose |
|------|---------|
| `frontend‑ralph‑loop‑workflow.md` | Complete workflow specification, architecture choices, phase‑by‑phase instructions. |
| `.claude‑multi‑agent.md` | System prompt for multi‑agent mode. Defines roles, communication protocols, and the full Ralph Loop. |
| `.claude‑unified‑agent.md` | System prompt for single‑agent mode. Describes the integrated Ralph Loop with self‑evaluation. |
| `feature_list_example.json` | Template for a structured task backlog. Contains atomic features with priorities, dependencies, and acceptance criteria. |
| `claude‑progress_example.txt` | Example of a cross‑session memory log. Records project milestones, feature completions, and lessons learned. |
| `design_spec_example.json` | Example cache of design tokens extracted from Figma (colors, fonts, spacing, component specs). |
| `init_example.sh` / `stop_example.sh` | Example scripts to start and stop a local development server. |

## How to Use This Repository

These files are **templates and examples**. To adopt the workflow in a real frontend project:

1. **Copy the example files** to your project root, removing the `_example` suffix:
   ```bash
   cp feature_list_example.json feature_list.json
   cp claude-progress_example.txt claude-progress.txt
   cp design_spec_example.json design_spec.json
   cp init_example.sh init.sh
   cp stop_example.sh stop.sh
   ```
2. **Customize** each file for your project (update feature definitions, design tokens, server commands).
3. **Ensure your project has** a `package.json` with a `verify` script (e.g., `"verify": "tsc --noEmit && eslint ."`).
4. **Connect the required MCP servers**:
   - **Figma MCP** to extract design specifications.
   - **Playwright MCP** for automated visual and functional testing.
5. **Choose a mode** and start Claude Code with the appropriate system prompt:
   ```bash
   # Multi‑agent mode
   claude --yes --system-prompt "./.claude-multi-agent.md"
   
   # Single‑agent mode  
   claude --yes --system-prompt "./.claude-unified-agent.md"
   ```

## Core Concepts

### Ralph Loop Phases (Simplified)

1. **Initialization** – Parse requirements, extract Figma specs, create feature list and memory files.
2. **Feature selection** – Pick the highest‑priority unfinished feature from `feature_list.json`.
3. **Design‑guided coding** – Implement using narrow‑scope file operations (`grep`, `cat`).
4. **Dual validation** – Run `npm run verify` (static analysis) + Playwright MCP (visual/functional tests).
5. **Decision** – If validation passes, proceed to state archival; if not, attempt repair (max 3 retries).
6. **Circuit‑breaker** – After 3 failures, stop and generate a detailed diagnostic report for human takeover.
7. **State archival** – Update `feature_list.json`, append to `claude‑progress.txt`, commit to Git.

### Externalized Memory

The workflow avoids relying on session context by storing all project state in files:

- **`feature_list.json`** – Source of truth for feature progress.
- **`claude‑progress.txt`** – Chronological log of what has been accomplished.
- **`design_spec.json`** – Cached design tokens from Figma (prevents repeated MCP calls).
- **Git commits** – Each completed feature is committed with a descriptive message.

### Attention‑Budget Management

Agents are instructed to **never load entire projects** into context. Instead they use `grep`, `cat`, and `find` to locate specific files and lines. This keeps the token window lean and enables multi‑hour sessions.

### Circuit‑Breaker (熔断机制)

To prevent infinite loops, the workflow enforces a hard limit of **3 automatic repair attempts** per feature. If the limit is reached, the agent stops all modifications and produces a structured **diagnostic report** that pinpoints the root cause and suggests concrete fixes for a human engineer.

## Notes for Claude Code

- This repository is **documentation/template‑only** – there is no build system, linting, or test suite to run.
- The example scripts (`init_example.sh`, `stop_example.sh`) are illustrative; adapt them to your project’s actual dev‑server commands.
- When helping a user adopt this workflow, focus on explaining the phase transitions, file formats, and the role of each MCP integration.
- The system prompts (`.claude‑multi‑agent.md`, `.claude‑unified‑agent.md`) are already complete; they can be used as‑is or tailored for specific project conventions.