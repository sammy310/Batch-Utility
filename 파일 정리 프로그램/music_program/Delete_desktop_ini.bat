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
set /p isDel=desktop.ini ������ �����Ͻðڽ��ϱ�?(y/n) : 
echo.

if !isDel!==y (
del /s "desktop.ini"
)
) else (
echo �������� �ʾҽ��ϴ�.
)

pause

endlocal