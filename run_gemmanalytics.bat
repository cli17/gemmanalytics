@echo off
setlocal EnableExtensions

rem GEMM Analytics runner with all CLI args exposed as defaults.
rem
rem Available arguments and options:
rem   --workload-params CSV                 default: .\default_workload_params.csv
rem   --machine-params CSV                  default: .\default_machine_params.csv
rem   --experiments CSV                     default: .\default_experiments.csv
rem   --mode {normal|debug}                 default: normal
rem   --output-order {execution|row_tracking} default: execution
rem   --output-txt PATH                     default: .\gemmanalytics_output.txt
rem   --output-csv PATH                     default: .\gemmanalytics_output.csv
rem   --output-xlsx PATH                    default: .\gemmanalytics_output.xlsx
rem   --output-equations-md PATH            default: .\EQUATIONS.md
rem   equations PDF output                  default: .\EQUATIONS.pdf (generated via pandoc+typst)
rem   --no-stdout                           default: false

rem Edit defaults here.
set "PYTHON_EXE=C:\Users\cli17\AppData\Local\Programs\Python\Python312\python.exe"
set "SCRIPT=gemmanalytics.py"
set "WORKLOAD_PARAMS=default_workload_params.csv"
set "MACHINE_PARAMS=default_machine_params.csv"
set "EXPERIMENTS=default_experiments.csv"
set "MODE=normal"
set "OUTPUT_ORDER=execution"
set "OUTPUT_TXT=gemmanalytics_output.txt"
set "OUTPUT_CSV=gemmanalytics_output.csv"
set "OUTPUT_XLSX=gemmanalytics_output.xlsx"
set "OUTPUT_EQUATIONS_MD=EQUATIONS.md"
set "OUTPUT_EQUATIONS_PDF=EQUATIONS.pdf"
set "NO_STDOUT=false"

set "CMD=%PYTHON_EXE% %SCRIPT%"
set "CMD=%CMD% --workload-params %WORKLOAD_PARAMS%"
set "CMD=%CMD% --machine-params %MACHINE_PARAMS%"
set "CMD=%CMD% --experiments %EXPERIMENTS%"
set "CMD=%CMD% --mode %MODE%"
set "CMD=%CMD% --output-order %OUTPUT_ORDER%"

if not "%OUTPUT_TXT%"=="" set "CMD=%CMD% --output-txt %OUTPUT_TXT%"
if not "%OUTPUT_CSV%"=="" set "CMD=%CMD% --output-csv %OUTPUT_CSV%"
if not "%OUTPUT_XLSX%"=="" set "CMD=%CMD% --output-xlsx %OUTPUT_XLSX%"
if not "%OUTPUT_EQUATIONS_MD%"=="" set "CMD=%CMD% --output-equations-md %OUTPUT_EQUATIONS_MD%"
if /I "%NO_STDOUT%"=="true" set "CMD=%CMD% --no-stdout"

echo Running:
echo   %CMD%
echo.

call %CMD%
set "EXIT_CODE=%ERRORLEVEL%"

if "%EXIT_CODE%"=="0" if not "%OUTPUT_EQUATIONS_MD%"=="" if not "%OUTPUT_EQUATIONS_PDF%"=="" call :generate_pdf

if not "%EXIT_CODE%"=="0" (
    echo.
    echo gemmanalytics failed with exit code %EXIT_CODE%.
) else (
    echo.
    echo gemmanalytics completed successfully.
)

exit /b %EXIT_CODE%

:generate_pdf
set "PANDOC_CMD=pandoc"
set "TYPST_CMD=typst"

where pandoc >nul 2>nul
if errorlevel 1 (
    if exist "%LOCALAPPDATA%\Programs\Pandoc\bin\pandoc.exe" set "PANDOC_CMD=%LOCALAPPDATA%\Programs\Pandoc\bin\pandoc.exe"
)

if /I "%PANDOC_CMD%"=="pandoc" (
    where pandoc >nul 2>nul
) else (
    if exist "%PANDOC_CMD%" (
        cmd /c exit /b 0
    ) else (
        cmd /c exit /b 1
    )
)
if errorlevel 1 (
    set "EXIT_CODE=1"
    echo.
    echo PDF generation failed: pandoc was not found.
    echo Run setup_gemmanalytics_tools.bat to install required tools.
    goto :eof
)

where typst >nul 2>nul
if errorlevel 1 (
    if exist "%LOCALAPPDATA%\Programs\Typst\bin\typst.exe" set "TYPST_CMD=%LOCALAPPDATA%\Programs\Typst\bin\typst.exe"
)

if /I "%TYPST_CMD%"=="typst" (
    where typst >nul 2>nul
) else (
    if exist "%TYPST_CMD%" (
        cmd /c exit /b 0
    ) else (
        cmd /c exit /b 1
    )
)
if errorlevel 1 (
    set "EXIT_CODE=1"
    echo.
    echo PDF generation failed: typst was not found.
    echo Run setup_gemmanalytics_tools.bat to install required tools.
    goto :eof
)

echo.
echo Generating PDF:
echo   %OUTPUT_EQUATIONS_PDF%

if exist "pdf_header.typ" (
    "%PANDOC_CMD%" "%OUTPUT_EQUATIONS_MD%" --from markdown+tex_math_dollars --pdf-engine="%TYPST_CMD%" --standalone --include-in-header="pdf_header.typ" -o "%OUTPUT_EQUATIONS_PDF%"
) else (
    "%PANDOC_CMD%" "%OUTPUT_EQUATIONS_MD%" --from markdown+tex_math_dollars --pdf-engine="%TYPST_CMD%" --standalone -o "%OUTPUT_EQUATIONS_PDF%"
)

if errorlevel 1 (
    set "EXIT_CODE=1"
    echo.
    echo PDF generation failed while running pandoc with typst.
)
goto :eof