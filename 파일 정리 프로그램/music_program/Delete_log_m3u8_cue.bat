@echo off

setlocal enabledelayedexpansion

:: cd /d %1

set /p isDel=.url������ �����Ͻðڽ��ϱ�?(y/n) : 
echo.

if !isDel!==y (
del /s "*.log"
del /s "*.m3u8"
) else (
echo �������� �ʾҽ��ϴ�.
)

pause

endlocal