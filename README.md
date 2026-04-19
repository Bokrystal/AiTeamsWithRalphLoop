  # AI团队前端开发Ralph Loop工作流模板

<div align="center" style="margin: 20px 0; padding: 15px; background-color: #f6f8fa; border-radius: 8px; border: 1px solid #e1e4e8;">
  <strong>🌐 语言选择 Language Selector</strong><br>
  <span>当前查看：<strong>中文版</strong></span> • 
  <a href="README-en.md">English Version</a> • 
  <a href="index.html">交互式选择页面</a>
</div>

## 📁 文件清单 

### 核心文档
1. **frontend‑ralph‑loop‑workflow.md** (12KB) – 主工作流文档
   - 完整的设计理念、架构模式选择、详细阶段说明
   - 包含多代理协同模式和单代理全能模式的对比
   - 质量控制、容错机制、扩展演进路线图

### 系统指令模板
2. **.claude‑multi‑agent.md** (8.7KB) – 多代理模式系统提示
   - 规划器、生成器、评估器的角色定义与工作流
   - 代理间通信协议、注意力预算管理规则
3. **.claude‑unified‑agent.md** (12KB) – 单代理模式系统提示
   - 全能代理的完整 Ralph Loop 实现
   - 熔断机制、设计规范遵从、Git 安全实践

### 配置与示例文件
4. **feature_list_example.json** (3.8KB) – 任务清单模板
   - 结构化特性定义、优先级排序、依赖管理
   - 包含赛博朋克博客项目的完整示例
5. **claude‑progress_example.txt** (2.9KB) – 记忆日志示例
   - 跨会话记忆格式、经验教训记录、交接注意事项
   - 包含熔断触发和人类接管的真实场景
6. **design_spec_example.json** (5.6KB) – 设计规范缓存示例
   - 从 Figma 提取的颜色、字体、间距、组件规范
   - 可直接用于开发的设计 Token 系统

### 工具脚本
7. **init_example.sh** (4.4KB) – 开发环境启动脚本
   - 自动检测项目类型、安装依赖、启动服务
   - 进程管理、日志记录、端口冲突处理
8. **stop_example.sh** (1KB) – 服务器停止脚本
   - 安全停止开发服务器、清理进程文件

## 🔧 工作流核心创新

### 1. 双模式架构
- **多代理协同模式** (复杂项目)：规划器 → 生成器 ↔ 评估器的专业分工
- **单代理全能模式** (轻量项目)：统一代理执行完整 Ralph Loop

### 2. 完整的 Ralph Loop 实现
特性选择 → 设计指导编码 → 双重验证 → [通过/修复/熔断] → 状态存档
- **双重验证**：代码静态检查 (`npm run verify`) + 多模态视觉验证 (Playwright MCP)
- **熔断机制**：3次重试后自动停止，生成详细诊断报告
- **上下文压缩**：Git提交 + 记忆文件更新，保持Token轻量

### 3. MCP 深度集成
- **Figma MCP**：自动提取设计规范，确保视觉一致性
- **Playwright MCP**：自动化视觉比对、交互测试、响应式验证

### 4. 防崩溃策略
- **Git安全网**：每个特性完成后立即提交
- **注意力预算管理**：窄范围文件操作，避免上下文过载
- **记忆外部化**：所有状态存储在文件中，不依赖会话历史

## 🚀 快速启动指南

### 多代理模式
```bash
# 启动规划器进行项目初始化
claude --yes --system‑prompt ".claude‑multi‑agent.md"
```

### 单代理模式
```bash
# 启动全能代理
claude --yes --system‑prompt ".claude‑unified‑agent.md"
```

### 项目准备步骤
1. 将示例文件复制到项目根目录并重命名（移除 `_example` 后缀）
2. 配置 `package.json` 中的 `verify` 脚本
3. 确保 Figma 和 Playwright MCP 服务器正常运行
4. 以 `--yes` 模式启动避免交互阻塞

## 📊 预期效果

这个工作流解决了原有方案的关键痛点：
- **打破AI盲目自信**：独立的评估器机制确保视觉和功能质量
- **防止烂尾**：强制原子化特性拆分，必须通过验证才能标记完成
- **无限续航**：Git提交 + 外部记忆文件实现跨会话连续性
- **及时熔断**：3次重试机制防止Token浪费在死循环中

所有文件都包含详细的注释和实际示例，您可以直接使用或根据具体项目进行调整。工作流设计为模块化，您可以单独采用其中的某些部分（如熔断机制、设计规范提取等）。