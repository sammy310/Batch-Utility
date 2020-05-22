@echo off

chcp 65001 >nul

setlocal enabledelayedexpansion

:: -----
set /p newPath=Path : 
if exist !newPath! (
cd /d !newPath!
)
:: -----

if not [%1]==[] ( cd /d %1 )

echo Video
set num1=0
for /f "usebackq tokens=1 delims=" %%g in (`dir *.mkv *.mp4 /a-d /b`) do (

set /a num1=num1+1
set list[!num1!]=%%~ng
echo [!num1!] : %%g
)

echo.
echo Subtitle
set num2=0
for /f "usebackq tokens=1 delims=" %%g in (`dir *.smi *.ass /a-d /b`) do (

set /a num2=num2+1
set sub1[!num2!]=%%~fg
set sub2[!num2!]=%%~xg
set sub3[!num2!]=%%~nxg
echo [!num2!] : %%g
)

:SELECTNUM

echo.
set /p select="0. No Change 1. Change 2. Slice Number 3. Slice Number(Video) 4. Slice Number(Sub) 5. Select Order : "
echo.
if !select! equ 0 ( goto EXIT
) else if !select! equ 1 (

for /l %%g in (1,1,!num2!) do (echo "!sub1[%%g]! -> !list[%%g]!!sub2[%%g]!")
echo.

set /p selectAnswer="Right?(y/n) : "

if !selectAnswer!==y ( for /l %%g in (1,1,!num2!) do (ren "!sub1[%%g]!" "!list[%%g]!!sub2[%%g]!") )

) else if !select! equ 2 (
set /p sliceStart="Start Number : "
set /p sliceEnd="End Number : "
echo.
for /l %%g in (!sliceStart!,1,!sliceEnd!) do (echo "!sub1[%%g]! -> !list[%%g]!!sub2[%%g]!")
echo.
set /p selectAnswer="Right?(y/n) : "

if !selectAnswer!==y ( for /l %%g in (!sliceStart!,1,!sliceEnd!) do (ren "!sub1[%%g]!" "!list[%%g]!!sub2[%%g]!") )

) else if !select! equ 3 (
set /p sliceStart="Video Start Number : "
set /p sliceEnd="Video End Number : "
echo.

set /a i=0
for /l %%g in (!sliceStart!,1,!sliceEnd!) do (
set /a i=i+1
for /l  %%h in (!i!,1,!i!) do ( echo "!sub1[%%h]! -> !list[%%g]!!sub2[%%g]!" )
)
echo.
set /p selectAnswer="Right?(y/n) : "

if !selectAnswer!==y (
set /a i=0
for /l %%g in (!sliceStart!,1,!sliceEnd!) do (
set /a i=i+1
for /l  %%h in (!i!,1,!i!) do ( ren "!sub1[%%h]!" "!list[%%g]!!sub2[%%h]!" )
) )

) else if !select! equ 4 (
set /p sliceStart="Subtitle Start Number : "
set /p sliceEnd="Subtitle End Number : "
echo.

set /a i=0
for /l %%g in (!sliceStart!,1,!sliceEnd!) do (
set /a i=i+1
for /l  %%h in (!i!,1,!i!) do ( echo "!sub1[%%g]! -> !list[%%h]!!sub2[%%h]!" )
)
echo.
set /p selectAnswer="Right?(y/n) : "

if !selectAnswer!==y (
set /a i=0
for /l %%g in (!sliceStart!,1,!sliceEnd!) do (
set /a i=i+1
for /l  %%h in (!i!,1,!i!) do ( ren "!sub1[%%g]!" "!list[%%h]!!sub2[%%g]!" )
) )

) else if !select! equ 5 (

echo ========================================
echo Input Order [If you done Input '0']
set /a i=0


:LOOP
set /a i=i+1

set /p order[!i!]="[!i!] : "

for /l %%g in (!i!,1,!i!) do (
if !order[%%g]! equ 0 (
set /a i=i-1
goto LOOPEND
) else if !order[%%g]! gtr !num2! (
echo Input ERR!!
goto EXIT
) else ( goto LOOP )
)

:LOOPEND
echo ========================================
for /l %%g in (1,1,!i!) do (
for /l %%h in (!order[%%g]!,1,!order[%%g]!) do (
echo "!sub3[%%h]! -> !list[%%g]!!sub2[%%g]!" )
)

echo ========================================
set /p selectAnswer="Right?(y/n) : "
if !selectAnswer!==y (
for /l %%g in (1,1,!i!) do (
for /l %%h in (!order[%%g]!,1,!order[%%g]!) do (
ren "!sub1[%%h]!" "!list[%%g]!!sub2[%%g]!" )
)
)
goto EXIT
) else (
echo Input ERR!!
goto SELECTNUM )

:EXIT

if [%1]==[] ( pause )

:: -----

endlocal

chcp 949 >nul
