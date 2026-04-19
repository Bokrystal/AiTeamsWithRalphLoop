#!/bin/bash

# ============================================
# 停止开发服务器脚本
# ============================================

echo "🛑 停止开发服务器..."

if [ ! -f ".dev_server.pid" ]; then
    echo "❌ 未找到 .dev_server.pid 文件，服务器可能未启动"
    exit 1
fi

DEV_PID=$(cat .dev_server.pid)

if [ -z "$DEV_PID" ]; then
    echo "❌ 进程ID为空"
    rm -f .dev_server.pid
    exit 1
fi

# 检查进程是否存在
if kill -0 $DEV_PID 2>/dev/null; then
    echo "📊 停止进程 $DEV_PID..."
    kill $DEV_PID

    # 等待进程结束
    sleep 2

    if kill -0 $DEV_PID 2>/dev/null; then
        echo "⚠️  进程仍在运行，强制终止..."
        kill -9 $DEV_PID
        sleep 1
    fi

    echo "✅ 开发服务器已停止"
else
    echo "⚠️  进程 $DEV_PID 已不存在"
fi

# 清理PID文件
rm -f .dev_server.pid

# 可选：清理日志文件
if [ "$1" = "--clean" ]; then
    echo "🧹 清理日志文件..."
    rm -f dev.log verify.log
fi

echo "🎯 完成"