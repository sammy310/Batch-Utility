@echo off

chcp 65001 >nul

setlocal enabledelayedexpansion

:: -----

if not [%1]==[] ( cd /d "%*" )

set /a n=0
for /f "usebackq tokens=1,2,* delims= " %%g in (`dir "*.mp3" /a-d /b`) do (
set /a n=n+1
ren "%%g %%h %%i" "0!n!. %%i"

)

if [%1]==[] ( pause )

:: -----

endlocal

chcp 949 >nul
