@echo off

chcp 65001 >nul

setlocal disabledelayedexpansion

:: -----

if not [%1]==[] ( cd /d "%*" )


for /f "usebackq tokens=1,* delims=." %%g in (`dir "*.flac" /a-d /b`) do (

ren "%%g.%%h" "0%%g.%%h"

)

if [%1]==[] ( pause )

:: -----

endlocal

chcp 949 >nul
