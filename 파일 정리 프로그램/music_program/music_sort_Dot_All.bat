@echo off

chcp 65001 >nul

setlocal disabledelayedexpansion

:: -----

if not [%1]==[] ( cd /d "%*" )

echo Current Directory : "%cd%"
echo.
echo mp3 List
for /f "usebackq tokens=1 delims=" %%g in (`dir "*.mp3" /a-d /b`) do (
echo %%g
)

echo.


setlocal enabledelayedexpansion

set /p select=Number Sort?(y/n) : 

if !select!==y (


setlocal disabledelayedexpansion

for /f "usebackq tokens=1,* delims=." %%g in (`dir "*.mp3" /a-d /b`) do (

ren "%%g.%%h" "%%g. %%h"

)

)

if [%1]==[] ( pause )

:: -----

endlocal

chcp 949 >nul
