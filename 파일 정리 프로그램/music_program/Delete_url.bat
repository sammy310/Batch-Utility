@echo off

setlocal enabledelayedexpansion

:: cd /d %1

set /p isDel=.url파일을 삭제하시겠습니까?(y/n) : 
echo.

if !isDel!==y (
del /s "*.url"
) else (
echo 삭제되지 않았습니다.
)

pause

endlocal