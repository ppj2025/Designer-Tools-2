@echo off
chcp 65001 > nul
echo =====================================================================
echo             小庞AI加油站 - Windows PC客户端一键构建脚本
echo =====================================================================
echo.
echo 正在检查 Node.js 运行环境...
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Node.js 环境！
    echo 请先前往官网下载安装 Node.js (推荐 v18 或 v20 LTS 版本): https://nodejs.org/
    echo 安装完成后，请重新双击运行此脚本。
    echo.
    pause
    exit /b 1
)

echo [1/3] 正在安装与校准项目依赖库 (npm install)...
call npm install
if %errorlevel% neq 0 (
    echo [错误] 依赖安装遇到问题，请检查网络或稍后重试。
    pause
    exit /b %errorlevel%
)

echo.
echo [2/3] 正在编译前端生产资源并调用 electron-builder 打包...
echo 打包格式包括：
echo   1. Windows 独立安装程序 (NSIS 安装向导)
echo   2. 免安装便携版 (Portable .exe，即开即用)
echo.
call npm run dist:win
if %errorlevel% neq 0 (
    echo [错误] 打包过程异常中断，请检查上方构建日志。
    pause
    exit /b %errorlevel%
)

echo.
echo =====================================================================
echo [🎉 打包成功！] 您的 PC 客户端安装程序已就绪！
echo 文件输出在当前目录的: release\ 文件夹内
echo.
echo 生成的 Windows 客户端文件：
echo  - 安装版: release\小庞AI加油站 Setup 1.0.0.exe (带桌面图标与卸载功能)
echo  - 便携版: release\小庞AI加油站 1.0.0.exe (无需安装，双击直接运行)
echo =====================================================================
echo.
explorer release
pause
