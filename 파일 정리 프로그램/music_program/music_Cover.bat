@echo off

chcp 65001 >nul

setlocal disabledelayedexpansion

:: -----

echo Cover.jpg Rename
echo.

for /f "usebackq tokens=1 delims=" %%k in (`dir "cover.jpg" /a-d /b /s`) do (

echo %%k

)

setlocal enabledelayedexpansion

echo.
set /p selectCV=Right?(y/n) : 
if !selectCV!==y (
setlocal disabledelayedexpansion

for /f "usebackq tokens=1 delims=" %%k in (`dir "cover.jpg" /a-d /b /s`) do (
ren "%%~k" "Cover.jpg"
)
) else (
echo No Rename
)


if [%1]==[] ( pause )

:: -----

endlocal

chcp 949 >nul
