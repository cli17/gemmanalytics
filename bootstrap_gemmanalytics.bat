@echo off
setlocal EnableExtensions

rem Bootstrap script for new contributors on Windows.
rem - Ensures required tools/packages are available
rem - Optionally runs a first generation pass
rem - Opens VS Code with gemmanalytics.py

set "RUN_GENERATION=1"
if /I "%~1"=="--no-run" set "RUN_GENERATION=0"

cd /d "%~dp0"

echo GEMM Analytics bootstrap

echo ========================
echo Repo root: %CD%
echo.

call setup_gemmanalytics_tools.bat
if errorlevel 1 (
    echo.
    echo Bootstrap stopped: tool setup failed.
    exit /b 1
)

if "%RUN_GENERATION%"=="1" (
    echo.
    echo Running initial generation to verify setup...
    call run_gemmanalytics.bat
    if errorlevel 1 (
        echo.
        echo Initial generation failed. Fix errors above and rerun bootstrap.
        exit /b 1
    )
) else (
    echo.
    echo Skipping initial generation (--no-run).
)

echo.
where code >nul 2>nul
if errorlevel 1 (
    echo VS Code CLI 'code' was not found on PATH.
    echo Open this folder in VS Code manually, then open gemmanalytics.py and start Copilot Chat.
) else (
    echo Opening VS Code...
    start "" code "%CD%"
    start "" code -g "%CD%\gemmanalytics.py:1"
)

echo.
echo Next steps:
echo 1) Edit default_machine_params.csv, default_workload_params.csv, and default_experiments.csv
echo 2) Run run_gemmanalytics.bat to regenerate outputs
echo 3) Run run_regression_gemmanalytics.bat before commit/push
echo.

echo Bootstrap complete.
exit /b 0
