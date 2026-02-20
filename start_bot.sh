#!/bin/bash
# Antigravity Discord Bot 起動スクリプト (Mac用)
cd "$(dirname "$0")"

APP_NAME="Antigravity"

# Antigravityが起動しているか確認
if pgrep -x "$APP_NAME" > /dev/null 2>&1 || pgrep -f "Antigravity" > /dev/null 2>&1; then
    echo "⚠️  Antigravityが起動中です。"
    echo "📝 作業中のファイルを保存したら、Enterを押してください..."
    read -r

    echo "🔴 Antigravityを終了しています..."
    osascript -e 'quit app "Antigravity"' 2>/dev/null
    sleep 2

    # まだ終了していない場合は強制終了
    if pgrep -f "Antigravity" > /dev/null 2>&1; then
        pkill -f "Antigravity" 2>/dev/null
        sleep 1
    fi
    echo "✅ Antigravityを終了しました。"
else
    echo "ℹ️  Antigravityは起動していません。"
fi

# デバッグモードでAntigravityを起動
echo "🚀 Antigravityをデバッグモード（ポート9222）で起動しています..."
open -a "$APP_NAME" --args --remote-debugging-port=9222
sleep 3
echo "✅ Antigravityが起動しました。"

# Botを起動
echo ""
echo "🤖 Antigravity Discord Bot を起動中..."
node discord_bot.js
