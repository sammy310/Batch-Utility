@echo off

chcp 65001 >nul

setlocal disabledelayedexpansion

:: -----

if not [%1]==[] ( cd /d "%*" )

for /f "usebackq tokens=1,* delims=-" %%g in (`dir "*.mp3" /a-d /b`) do (

ren "%%g-%%h" "%%g. %%h"

)

if [%1]==[] ( pause )

:: -----

endlocal

chcp 949 >nul
