@echo off

setlocal enabledelayedexpansion

::chcp 65001 >nul

title Get Directory Or Tree

if not [%1]==[] (
cd /d %1
) else ( cd /d %cd% )

::NEWPATH
set /p newPath=Input Path[Where You Get] : 

if exist !newPath! (
set /p select=1. Get Directory 2. Get Tree 3. Both : 

if !select! equ 1 (
::dir !newPath!\*.* /ad /b > new_dir.txt
call "get_dir.bat" "!newPath!"
) else if !select! equ 2 (
tree /f !newPath! > new_tree.txt
) else if !select! equ 3 (
call "get_dir.bat" "!newPath!"
tree /f !newPath! > new_tree.txt
) else ( echo.
goto NEWPATH
)
) else ( echo.
goto NEWPATH )

pause

::chcp 949 >nul

endlocal
