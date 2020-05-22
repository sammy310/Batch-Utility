@echo off

setlocal disabledelayedexpansion

:: cd /d %1

for /f "usebackq tokens=1 delims=" %%g in (`dir *.* /a-d /b /s`) do (
if %%~xg==.txt (
echo %%g
)
)

setlocal enabledelayedexpansion

echo.
set /p isDel=.txt파일을 삭제하시겠습니까?(y/n) : 
echo.

if !isDel!==y (
del /s "*.txt"
) else (
echo 삭제되지 않았습니다.
)

pause

endlocal