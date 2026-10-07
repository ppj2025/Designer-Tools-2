@echo off
chcp 65001 >nul
title PixelStudio AI 桌面端一键打包工具

echo ========================================================
echo   PixelStudio AI - 正在配置国内高速镜像并准备打包...
echo ========================================================
echo.

echo [1/3] 正在设置国内镜像源（解决 GitHub 网络连接报错）...
call npm config set registry https://registry.npmmirror.com
set ELECTRON_MIRROR=https://npmmirror.com/mirrors/electron/
set ELECTRON_BUILDER_BINARIES_MIRROR=https://npmmirror.com/mirrors/electron-builder-binaries/

echo.
echo [2/3] 正在安装依赖包（请耐心等待 1-3 分钟）...
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [错误] 依赖安装失败，请检查网络或 Node.js 版本后重试。
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo [3/3] 正在构建前端并打包 Windows EXE 应用程序...
call npm run dist
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [错误] 打包失败，请检查报错日志。
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo ========================================================
echo   恭喜！打包成功！
echo   请在生成的 [release] 文件夹中查看您的 .exe 安装程序！
echo ========================================================
echo.
pause
