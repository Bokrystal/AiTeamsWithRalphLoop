#!/bin/bash

# ============================================
# 前端开发环境启动脚本
# 用于 Ralph Loop 工作流的 Phase 3.2 本地环境验证
# ============================================

set -e  # 遇到错误时退出脚本

echo "🚀 启动前端开发环境..."

# 检查 Node.js 和 npm 是否已安装
if ! command -v node &> /dev/null; then
    echo "❌ Node.js 未安装。请先安装 Node.js (>= 16.0.0)"
    exit 1
fi

if ! command -v npm &> /dev/null; then
    echo "❌ npm 未安装。请先安装 npm"
    exit 1
fi

# 检查 package.json 是否存在
if [ ! -f "package.json" ]; then
    echo "❌ package.json 不存在。请在项目根目录运行此脚本"
    exit 1
fi

# 解析项目类型
PROJECT_TYPE="unknown"
if grep -q '"react"' package.json; then
    PROJECT_TYPE="react"
elif grep -q '"vue"' package.json; then
    PROJECT_TYPE="vue"
elif grep -q '"svelte"' package.json; then
    PROJECT_TYPE="svelte"
fi

echo "📦 检测到项目类型: $PROJECT_TYPE"

# 检查 node_modules 是否存在，如不存在则安装依赖
if [ ! -d "node_modules" ]; then
    echo "📥 node_modules 不存在，正在安装依赖..."
    npm install
else
    echo "✅ 依赖已安装"
fi

# 检查开发服务器是否已经在运行
PORT=5173  # Vite 默认端口
if command -v lsof &> /dev/null; then
    # macOS/Linux 系统
    if lsof -ti:$PORT &> /dev/null; then
        echo "⚠️  端口 $PORT 已被占用，尝试停止现有进程..."
        lsof -ti:$PORT | xargs kill -9 2>/dev/null || true
        sleep 2
    fi
elif command -v netstat &> /dev/null; then
    # Windows 系统 (git bash)
    if netstat -ano | grep ":$PORT" | grep "LISTENING" &> /dev/null; then
        echo "⚠️  端口 $PORT 已被占用，请手动停止占用该端口的进程"
        # 在 Windows 中自动结束进程可能不安全，这里仅警告
    fi
fi

# 启动开发服务器
echo "🌐 启动开发服务器..."

# 根据 package.json 中的 scripts 启动
if grep -q '"dev"' package.json; then
    echo "📝 使用 'npm run dev' 启动..."
    # 在后台启动，并将输出重定向到日志文件
    nohup npm run dev > dev.log 2>&1 &
    DEV_PID=$!
elif grep -q '"start"' package.json; then
    echo "📝 使用 'npm start' 启动..."
    nohup npm start > dev.log 2>&1 &
    DEV_PID=$!
else
    echo "❌ package.json 中未找到 'dev' 或 'start' 脚本"
    exit 1
fi

echo "📊 开发服务器进程 ID: $DEV_PID"
echo "📄 日志文件: dev.log"

# 等待服务器启动
echo "⏳ 等待服务器启动 (最多30秒)..."
MAX_WAIT=30
WAITED=0

while [ $WAITED -lt $MAX_WAIT ]; do
    sleep 2
    WAITED=$((WAITED + 2))

    # 检查进程是否还在运行
    if ! kill -0 $DEV_PID 2>/dev/null; then
        echo "❌ 开发服务器进程已退出。检查日志:"
        tail -20 dev.log
        exit 1
    fi

    # 尝试访问服务器
    if curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT > /dev/null 2>&1; then
        echo "✅ 开发服务器已启动!"
        echo "🔗 访问地址: http://localhost:$PORT"
        echo "📋 快速命令:"
        echo "   查看日志: tail -f dev.log"
        echo "   停止服务器: kill $DEV_PID"
        echo "   验证代码: npm run verify"
        break
    fi

    echo "  等待中... ($WAITED/$MAX_WAIT 秒)"
done

if [ $WAITED -ge $MAX_WAIT ]; then
    echo "❌ 服务器启动超时。检查日志:"
    tail -30 dev.log
    exit 1
fi

# 保存进程ID到文件，便于后续管理
echo $DEV_PID > .dev_server.pid
echo "💾 服务器进程ID已保存到 .dev_server.pid"

# 运行初始验证
echo "🔍 运行初始代码验证..."
if npm run verify 2>&1 | tee verify.log; then
    echo "✅ 代码验证通过!"
else
    echo "⚠️  代码验证发现一些问题。详情见 verify.log"
    echo "   但开发服务器继续运行，你可以在开发过程中修复这些问题。"
fi

echo ""
echo "============================================"
echo "🎉 开发环境准备就绪!"
echo "============================================"
echo ""
echo "接下来请执行:"
echo "1. 修改代码文件"
echo "2. 运行验证: npm run verify"
echo "3. 使用 Playwright MCP 进行视觉验证"
echo ""
echo "要停止服务器，运行: ./stop_dev.sh 或 kill \$(cat .dev_server.pid)"
echo "============================================"

# 脚本结束，但服务器继续在后台运行
exit 0