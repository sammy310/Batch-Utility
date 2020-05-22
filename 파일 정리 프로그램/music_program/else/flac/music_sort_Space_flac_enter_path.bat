@echo off

chcp 65001 >nul

setlocal disabledelayedexpansion

:: -----

if not [%1]==[] ( cd /d "%*" )

:: -----

setlocal enabledelayedexpansion

set /p sortPath=Path : 
cd /d !sortPath!

setlocal disabledelayedexpansion

:: -----

for /f "usebackq tokens=1,* delims= " %%g in (`dir "*.flac" /a-d /b`) do (

ren "%%g %%h" "%%g. %%h"

)

if [%1]==[] ( pause )

:: -----

endlocal

chcp 949 >nul
