@echo off

setlocal enabledelayedexpansion

:: cd /d %1

set /p isDel=.url파일을 삭제하시겠습니까?(y/n) : 
echo.

if !isDel!==y (
del /s "*.log"
del /s "*.m3u8"
) else (
echo 삭제되지 않았습니다.
)

pause

endlocal