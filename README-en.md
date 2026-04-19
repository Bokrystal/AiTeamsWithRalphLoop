# AI Team Frontend Development Ralph Loop Workflow Templates

<div align="center" style="margin: 20px 0; padding: 15px; background-color: #f6f8fa; border-radius: 8px; border: 1px solid #e1e4e8;">
  <strong>🌐 Language Selector 语言选择</strong><br>
  <span>Currently viewing: <strong>English Version</strong></span> • 
  <a href="README.md">中文版 (Chinese)</a> • 
  <a href="index.html">Interactive Selector</a>
</div>

## 📁 File Inventory

### Core Documentation
1. **frontend‑ralph‑loop‑workflow.md** (12KB) – Main workflow document
   - Complete design philosophy, architecture pattern selection, detailed phase descriptions
   - Comparison of multi‑agent collaborative mode and single‑agent unified mode
   - Quality control, fault‑tolerance mechanisms, evolution roadmap

### System Instruction Templates
2. **.claude‑multi‑agent.md** (8.7KB) – Multi‑agent mode system prompt
   - Role definitions and workflows for Planner, Generator, Evaluator
   - Inter‑agent communication protocols, attention‑budget management rules
3. **.claude‑unified‑agent.md** (12KB) – Single‑agent mode system prompt
   - Complete Ralph Loop implementation for a unified agent
   - Circuit‑breaker mechanism, design‑specification compliance, Git safety practices

### Configuration & Example Files
4. **feature_list_example.json** (3.8KB) – Task‑backlog template
   - Structured feature definitions, priority ordering, dependency management
   - Complete example for a cyberpunk‑style blog project
5. **claude‑progress_example.txt** (2.9KB) – Memory‑log example
   - Cross‑session memory format, lessons‑learned records, handover notes
   - Real‑world scenarios including circuit‑breaker triggers and human takeover
6. **design_spec_example.json** (5.6KB) – Design‑specification cache example
   - Color, font, spacing, component specifications extracted from Figma
   - Design‑token system ready for immediate development use

### Tool Scripts
7. **init_example.sh** (4.4KB) – Development‑environment startup script
   - Automatic project‑type detection, dependency installation, service startup
   - Process management, logging, port‑conflict handling
8. **stop_example.sh** (1KB) – Server‑stop script
   - Safely stops development servers, cleans up process files

## 🔧 Workflow Core Innovations

### 1. Dual‑Mode Architecture
- **Multi‑agent collaborative mode** (complex projects): Professional division among Planner → Generator ↔ Evaluator
- **Single‑agent unified mode** (lightweight projects): Unified agent executes the full Ralph Loop

### 2. Complete Ralph Loop Implementation
Feature selection → Design‑guided coding → Dual verification → [Pass/Fix/Circuit‑breaker] → State archiving
- **Dual verification**: Code static checking (`npm run verify`) + multimodal visual verification (Playwright MCP)
- **Circuit‑breaker mechanism**: Automatically stops after 3 retries, generates detailed diagnostic reports
- **Context compression**: Git commits + memory‑file updates keep token usage lightweight

### 3. Deep MCP Integration
- **Figma MCP**: Automatically extracts design specifications, ensures visual consistency
- **Playwright MCP**: Automated visual comparison, interaction testing, responsive verification

### 4. Anti‑Crash Strategies
- **Git safety net**: Immediate commit after each feature completion
- **Attention‑budget management**: Narrow‑scope file operations avoid context overload
- **Memory externalization**: All state stored in files, not dependent on session history

## 🚀 Quick‑Start Guide

### Multi‑Agent Mode
```bash
# Start the Planner for project initialization
claude --yes --system‑prompt ".claude‑multi‑agent.md"
```

### Single‑Agent Mode
```bash
# Start the unified agent
claude --yes --system‑prompt ".claude‑unified‑agent.md"
```

### Project Preparation Steps
1. Copy the example files to your project root and rename them (remove the `_example` suffix)
2. Configure the `verify` script in your `package.json`
3. Ensure the Figma and Playwright MCP servers are running normally
4. Start in `--yes` mode to avoid interaction blocking

## 📊 Expected Results

This workflow solves key pain points of previous approaches:
- **Breaks AI overconfidence**: Independent evaluator mechanism ensures visual and functional quality
- **Prevents abandonment**: Enforces atomic feature splitting; must pass verification to mark as complete
- **Infinite endurance**: Git commits + external memory files enable cross‑session continuity
- **Timely circuit‑breaking**: 3‑retry mechanism prevents token waste in dead loops

All files include detailed comments and practical examples. You can use them directly or adjust them for specific projects. The workflow is modular—you can adopt individual parts (circuit‑breaker mechanism, design‑specification extraction, etc.) separately.