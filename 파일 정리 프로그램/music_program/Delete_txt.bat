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
set /p isDel=.txt������ �����Ͻðڽ��ϱ�?(y/n) : 
echo.

if !isDel!==y (
del /s "*.txt"
) else (
echo �������� �ʾҽ��ϴ�.
)

pause

endlocal