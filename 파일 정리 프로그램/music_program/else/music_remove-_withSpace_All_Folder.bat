@echo off

chcp 65001 >nul

setlocal disabledelayedexpansion

set SortProgram=music_remove-_withSpace.bat

:: -----

if not [%1]==[] ( cd /d "%*" )


for /f "usebackq tokens=1 delims=" %%k in (`dir *.* /ad /b /s`) do (
if /i not %%~nxk==BK (
call "%cd%\%SortProgram%" %%k )
)

if [%1]==[] ( pause )

:: -----

endlocal

chcp 949 >nul
