@echo off

chcp 65001 >nul

setlocal disabledelayedexpansion
title Move Sub files

:: -----

if not [%1]==[] ( cd /d %* )

if /i not exist mp3 ( goto FOLDERERR )

cd /d mp3

echo Move Files...
for /f "usebackq tokens=1 delims=" %%g in (`dir . /a /b`) do (
move /-y "%%g" ".."
)

echo.
echo Current Path : "%cd%"
echo ===== Current Files =====
dir /b

:DELETEFOLDER

setlocal enabledelayedexpansion

echo.
set /p isDel=Delete MP3 Folder?(y/n) : 

if !isDel!==y (
cd /d ..
rd mp3
) else if !isDel!==n (
cd /d ..
) else ( goto DELETEFOLDER )

if [%1]==[] ( pause )

goto EXIT

:FOLDERERR
echo MP3 Folder is NOT Exist!!
pause
goto EXIT

:: -----

:EXIT

endlocal

chcp 949 >nul
