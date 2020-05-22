@echo off

chcp 65001 >nul

setlocal disabledelayedexpansion

:: -----

if not [%1]==[] ( cd /d "%*" )


cd /d flac

for /f "usebackq tokens=1,* delims=." %%g in (`dir "*.flac" /a-d /b`) do (

ren "%%g.%%h" "0%%g.%%h"

)


for /f "usebackq tokens=1 delims=" %%h in (`dir . /a /b`) do (
move /-y "%%h" ".."
)

echo.
echo Current Path : "%cd%"
echo ===== Current Files =====
dir /b

:DELETEFOLDER

setlocal enabledelayedexpansion

echo.
set /p isDel=Delete flac Folder?(y/n) : 

if !isDel!==y (
cd /d ..
rd flac
) else if !isDel!==n (
cd /d ..
) else ( goto DELETEFOLDER )

if [%1]==[] ( pause )

:: -----

endlocal

chcp 949 >nul
