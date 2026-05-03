@echo off
setlocal EnableExtensions

set "CHECK_ONLY=0"
if /I "%~1"=="--check" set "CHECK_ONLY=1"

set "SETUP_FAILED=0"
set "WINGET_OK=0"
set "PY_CMD="
set "PY_LABEL="

where winget >nul 2>nul
if not errorlevel 1 set "WINGET_OK=1"

echo GEMM Analytics tool setup
echo ========================
echo.
if "%CHECK_ONLY%"=="1" echo Running in check-only mode. No installations will be attempted.
if "%CHECK_ONLY%"=="1" echo.

call :ensure_python_runtime
call :ensure_tool pandoc "Pandoc.Pandoc" "Pandoc"
call :ensure_tool typst "Typst.Typst" "Typst"

call :ensure_python_package pypdfium2
call :ensure_python_package Pillow
call :ensure_python_package numpy
call :ensure_python_package openpyxl

echo.
echo Tool versions:
if defined PY_CMD (
	%PY_CMD% --version 2>nul
)
pandoc --version 2>nul
typst --version 2>nul

echo.
if "%SETUP_FAILED%"=="0" goto :setup_ok
echo Setup finished with errors. See messages above for missing tools.
exit /b 1

:setup_ok
echo Setup complete. All required tools are available.
echo You can now run run_gemmanalytics.bat to generate txt, csv, md, and typst-based pdf outputs.
exit /b 0

:ensure_python_runtime
call :detect_python_command
if defined PY_CMD (
	echo [OK] %PY_LABEL% is available.
	goto :eof
)

echo [MISSING] Python runtime was not found.
if "%CHECK_ONLY%"=="1" (
	set "SETUP_FAILED=1"
	goto :eof
)

if "%WINGET_OK%"=="1" (
	echo Installing Python 3.12 via winget - Python.Python.3.12 ...
	winget install --id Python.Python.3.12 --exact --accept-package-agreements --accept-source-agreements
	if errorlevel 1 (
		echo [ERROR] Failed to install Python 3.12 with winget.
		set "SETUP_FAILED=1"
		goto :eof
	)
	call :detect_python_command
	if defined PY_CMD (
		echo [OK] %PY_LABEL% installed.
		goto :eof
	)
	echo [ERROR] Python install completed but command is not visible in this shell.
	echo Open a new terminal and run this setup again.
	set "SETUP_FAILED=1"
	goto :eof
)

echo [ERROR] winget is not available and Python is missing.
echo Install Python 3.12 from python.org (include pip and py launcher), then rerun this script.
set "SETUP_FAILED=1"
goto :eof

:detect_python_command
set "PY_CMD="
set "PY_LABEL="

where python >nul 2>nul
if not errorlevel 1 (
	set "PY_CMD=python"
	set "PY_LABEL=python"
	goto :eof
)

where py >nul 2>nul
if not errorlevel 1 (
	py -3 --version >nul 2>nul
	if not errorlevel 1 (
		set "PY_CMD=py -3"
		set "PY_LABEL=py -3"
		goto :eof
	)
	py --version >nul 2>nul
	if not errorlevel 1 (
		set "PY_CMD=py"
		set "PY_LABEL=py"
		goto :eof
	)
)
goto :eof

:ensure_tool
set "TOOL_CMD=%~1"
set "WINGET_ID=%~2"
set "TOOL_LABEL=%~3"

where %TOOL_CMD% >nul 2>nul
if not errorlevel 1 goto :tool_ok

echo [MISSING] %TOOL_LABEL% was not found.

if "%CHECK_ONLY%"=="1" goto :tool_missing_check_only

if not "%WINGET_OK%"=="1" goto :winget_missing

echo Installing %TOOL_LABEL% via winget - %WINGET_ID% ...
winget install --id %WINGET_ID% --exact --accept-package-agreements --accept-source-agreements
if errorlevel 1 goto :install_failed

where %TOOL_CMD% >nul 2>nul
if errorlevel 1 goto :not_on_path_yet

echo [OK] %TOOL_LABEL% installed.
goto :eof

:tool_ok
echo [OK] %TOOL_LABEL% is already installed.
goto :eof

:tool_missing_check_only
set "SETUP_FAILED=1"
goto :eof

:install_failed
echo [ERROR] Failed to install %TOOL_LABEL% with winget.
set "SETUP_FAILED=1"
goto :eof

:not_on_path_yet
echo [ERROR] %TOOL_LABEL% install completed but command is still unavailable in this shell.
echo Open a new terminal and run this setup again.
set "SETUP_FAILED=1"
goto :eof

:winget_missing
echo winget is not available. Trying direct install for %TOOL_LABEL%...
call :direct_install_%TOOL_CMD%
if errorlevel 1 (
	echo [ERROR] Direct install failed for %TOOL_LABEL%.
	echo Install it manually, then run this script again.
	set "SETUP_FAILED=1"
	goto :eof
)

where %TOOL_CMD% >nul 2>nul
if errorlevel 1 (
	echo [ERROR] %TOOL_LABEL% was installed but is not visible in this shell yet.
	echo Open a new terminal and run this setup again.
	set "SETUP_FAILED=1"
	goto :eof
)

echo [OK] %TOOL_LABEL% installed via direct install.
goto :eof

:direct_install_python
exit /b 1

:direct_install_pandoc
set "PANDOC_ZIP=%TEMP%\pandoc-latest-x64.zip"
set "PANDOC_ROOT=%LOCALAPPDATA%\Programs\Pandoc"
set "PANDOC_BIN=%LOCALAPPDATA%\Programs\Pandoc\bin"

powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; $rel = Invoke-RestMethod -Headers @{ 'User-Agent'='gemmanalytics-setup' } -Uri 'https://api.github.com/repos/jgm/pandoc/releases/latest'; $asset = $null; foreach ($a in $rel.assets) { if ($a.name -like '*windows*x86_64*.zip') { $asset = $a; break } }; if (-not $asset) { throw 'No pandoc Windows zip asset found.' }; Invoke-WebRequest -Uri $asset.browser_download_url -OutFile '%PANDOC_ZIP%'"
if errorlevel 1 exit /b 1

powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; $root='%PANDOC_ROOT%'; $bin='%PANDOC_BIN%'; [void](New-Item -ItemType Directory -Path $root -Force); [void](New-Item -ItemType Directory -Path $bin -Force); $extract = Join-Path $root 'extract'; if (Test-Path $extract) { Remove-Item -Recurse -Force $extract }; Expand-Archive -LiteralPath '%PANDOC_ZIP%' -DestinationPath $extract -Force; $exe = Get-ChildItem -Path $extract -Recurse -Filter pandoc.exe | Select-Object -First 1; if (-not $exe) { throw 'pandoc.exe not found in archive.' }; $srcDir = Split-Path -Parent $exe.FullName; Copy-Item -Path (Join-Path $srcDir '*') -Destination $bin -Recurse -Force; Remove-Item -Recurse -Force $extract; $userPath = [Environment]::GetEnvironmentVariable('Path', 'User'); if (-not $userPath) { $userPath = '' }; $parts = $userPath -split ';'; if (-not ($parts -contains $bin)) { $newPath = ($userPath.TrimEnd(';') + ';' + $bin).Trim(';'); [Environment]::SetEnvironmentVariable('Path', $newPath, 'User') }"
set "ZIP_CODE=%ERRORLEVEL%"
del "%PANDOC_ZIP%" >nul 2>nul
if not "%ZIP_CODE%"=="0" exit /b 1

set "PATH=%PATH%;%PANDOC_BIN%"
exit /b 0

:direct_install_typst
set "TYPST_ZIP=%TEMP%\typst-latest-x64.zip"
set "TYPST_ROOT=%LOCALAPPDATA%\Programs\Typst"
set "TYPST_BIN=%LOCALAPPDATA%\Programs\Typst\bin"

powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; $rel = Invoke-RestMethod -Headers @{ 'User-Agent'='gemmanalytics-setup' } -Uri 'https://api.github.com/repos/typst/typst/releases/latest'; $asset = $null; foreach ($a in $rel.assets) { if ($a.name -like '*x86_64-pc-windows-msvc*.zip') { $asset = $a; break } }; if (-not $asset) { throw 'No typst Windows zip asset found.' }; Invoke-WebRequest -Uri $asset.browser_download_url -OutFile '%TYPST_ZIP%'"
if errorlevel 1 exit /b 1

powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; $root='%TYPST_ROOT%'; $bin='%TYPST_BIN%'; [void](New-Item -ItemType Directory -Path $root -Force); [void](New-Item -ItemType Directory -Path $bin -Force); $extract = Join-Path $root 'extract'; if (Test-Path $extract) { Remove-Item -Recurse -Force $extract }; Expand-Archive -LiteralPath '%TYPST_ZIP%' -DestinationPath $extract -Force; $exe = Get-ChildItem -Path $extract -Recurse -Filter typst.exe | Select-Object -First 1; if (-not $exe) { throw 'typst.exe not found in archive.' }; Copy-Item -LiteralPath $exe.FullName -Destination (Join-Path $bin 'typst.exe') -Force; Remove-Item -Recurse -Force $extract; $userPath = [Environment]::GetEnvironmentVariable('Path', 'User'); if (-not $userPath) { $userPath = '' }; $parts = $userPath -split ';'; if (-not ($parts -contains $bin)) { $newPath = ($userPath.TrimEnd(';') + ';' + $bin).Trim(';'); [Environment]::SetEnvironmentVariable('Path', $newPath, 'User') }"
set "ZIP_CODE=%ERRORLEVEL%"
del "%TYPST_ZIP%" >nul 2>nul
if not "%ZIP_CODE%"=="0" exit /b 1

set "PATH=%PATH%;%TYPST_BIN%"
exit /b 0

:ensure_python_package
set "PKG_NAME=%~1"

if not defined PY_CMD (
	call :detect_python_command
)
if not defined PY_CMD (
	echo [ERROR] Cannot verify package %PKG_NAME% because Python is unavailable.
	set "SETUP_FAILED=1"
	goto :eof
)

%PY_CMD% -c "import importlib.util, sys; sys.exit(0 if importlib.util.find_spec('%PKG_NAME%') else 1)" >nul 2>nul
if not errorlevel 1 (
	echo [OK] Python package %PKG_NAME% is already installed.
	goto :eof
)

echo [MISSING] Python package %PKG_NAME% is required for regression tests.

if "%CHECK_ONLY%"=="1" (
	set "SETUP_FAILED=1"
	goto :eof
)

echo Installing Python package %PKG_NAME% ...
%PY_CMD% -m pip install --user --disable-pip-version-check %PKG_NAME%
if errorlevel 1 (
	echo [ERROR] Failed to install Python package %PKG_NAME%.
	set "SETUP_FAILED=1"
	goto :eof
)

%PY_CMD% -c "import importlib.util, sys; sys.exit(0 if importlib.util.find_spec('%PKG_NAME%') else 1)" >nul 2>nul
if errorlevel 1 (
	echo [ERROR] Python package %PKG_NAME% install completed but import still failed.
	set "SETUP_FAILED=1"
	goto :eof
)

echo [OK] Python package %PKG_NAME% installed.
goto :eof