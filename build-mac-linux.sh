#!/usr/bin/env bash
set -e

echo "====================================================================="
echo "            小庞AI加油站 - macOS / Linux PC 客户端打包脚本"
echo "====================================================================="
echo ""

if ! command -v node &> /dev/null; then
    echo "[错误] 未检测到 Node.js，请先安装 Node.js (推荐 v18+ 或 v20+)"
    exit 1
fi

echo "[1/2] 正在安装依赖库..."
npm install

OS="$(uname -s)"
case "${OS}" in
    Darwin*)
        echo "[2/2] 正在打包为 macOS 应用程序 (.dmg 和 .zip)..."
        npm run dist:mac
        echo ""
        echo "====================================================================="
        echo "[🎉 打包完成！] macOS 安装镜像已输出在: ./release/"
        echo "====================================================================="
        open release || true
        ;;
    Linux*)
        echo "[2/2] 正在打包为 Linux 应用程序 (.AppImage 和 .deb)..."
        npm run dist:linux
        echo ""
        echo "====================================================================="
        echo "[🎉 打包完成！] Linux 安装包已输出在: ./release/"
        echo "====================================================================="
        ;;
    *)
        echo "未识别的操作系统，执行默认构建..."
        npm run dist
        ;;
esac
