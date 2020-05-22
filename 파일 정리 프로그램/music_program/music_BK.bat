@echo off

chcp 65001 >nul

setlocal disabledelayedexpansion

:: -----

echo BK(JPG) Rename
echo.

for /f "usebackq tokens=1 delims=" %%k in (`dir "bk(jpg)" /ad /b /s`) do (

echo %%k

)

setlocal enabledelayedexpansion

echo.
set /p selectBK=Right?(y/n) : 
if !selectBK!==y (
setlocal disabledelayedexpansion

for /f "usebackq tokens=1 delims=" %%k in (`dir "bk(jpg)" /ad /b /s`) do (
ren "%%k" "BK"
)
) else (
echo No Rename
)


if [%1]==[] ( pause )

:: -----

endlocal

chcp 949 >nul
