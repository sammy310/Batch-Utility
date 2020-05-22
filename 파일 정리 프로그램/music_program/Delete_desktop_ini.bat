@echo off

setlocal disabledelayedexpansion

:: cd /d %1

for /f "usebackq tokens=1 delims=" %%g in (`dir *.* /a-d /b /s`) do (
if %%~nxg==desktop.ini (
echo %%g
)
)

setlocal enabledelayedexpansion

echo.
set /p isDel=desktop.ini 파일을 삭제하시겠습니까?(y/n) : 
echo.

if !isDel!==y (
del /s "desktop.ini"
)
) else (
echo 삭제되지 않았습니다.
)

pause

endlocal