@echo off

setlocal enabledelayedexpansion
title 파일 정리 프로그램

set startPath=%cd%
set MusicSortProgram=music_program\music_sort_Dot.bat
set AllMusicSortProgram=music_program\music_sort_Dot_All.bat
set MusicSortProgramSpace=music_program\music_sort_Space.bat
set AllMusicSortProgramSpace=music_program\music_sort_Space_All.bat
set MoveMp3Program=music_program\move_to_upperfolder.bat
set SubSortProgram=sub_sort.bat
set CoverRenameProgram=music_program\music_Cover.bat
set BKRenameProgram=music_program\music_BK.bat

chcp 949 > nul

:: ================================================================================
:GETLIST
cls

echo 현재 경로 : %cd%
echo ================================================================================
echo 파일 목록
dir *.* /a-d /b

echo ================================================================================
echo 폴더 목록
echo [0] : 상위 폴더

set num=0
for /f "usebackq tokens=1 delims=" %%g in (`dir *.* /ad /b`) do (
set /a num=num+1
set list[!num!]=%%g
echo [!num!] : %%~nxg
)

:: ================================================================================
:PRINT

echo ================================================================================
echo 0. 경로 설정 1. 파일 이동
echo 11. 현재 디렉토리의 노래 숫자 정리 12. 모든 폴더의 노래 숫자 정리 13. mp3 파일 체크 (16, 17 : Space 구분)
echo 21. MP3 폴더 체크 22. MP3 폴더안의 파일 꺼내기 23. 모든 MP3 폴더 정리
echo 31. 현재 디렉토리로부터 노래 파일 정리 32. Cover 정리 33. BK 폴더 정리
set /p select=41. 자막 정리 99. 종료 : 
echo.

if !select! equ 0 ( goto SETPATH
) else if !select! equ 1 ( goto MOVE
) else if !select! equ 11 ( goto NUMBERSORT
) else if !select! equ 12 ( goto ALLNUMBERSORT
) else if !select! equ 13 ( goto NUMBERCHECK
) else if !select! equ 16 ( goto NUMBERSORTSPACE
) else if !select! equ 17 ( goto ALLNUMBERSORTSPACE
) else if !select! equ 21 ( goto CHECKMP3
) else if !select! equ 22 ( goto MOVEMP3
) else if !select! equ 23 ( goto LOOPMP3
) else if !select! equ 31 ( goto DELTRASH
) else if !select! equ 32 ( goto COVER
) else if !select! equ 33 ( goto BKFOLDER
) else if !select! equ 41 ( goto SUBSORT
) else if !select! equ 99 ( goto EXIT
) else ( goto PRINT )

:: ================================================================================
:SETPATH
set /p newPath=새로운 경로 : 
if exist !newPath! (
cd /d !newPath!

goto GETLIST
) else (
echo 잘못된 경로를 입력했습니다!

goto PRINT
)

:: ================================================================================
:MOVE
set /p moveIndex=폴더 번호 : 

if !moveIndex! equ 0 (
cd /d ..
) else if !moveIndex! GEQ 0 (
if !moveIndex! LEQ !num! (
cd /d !list[%moveIndex%]!
) else (
echo 잘못된 값을 입력했습니다!

goto PRINT
) ) else (
echo 잘못된 값을 입력했습니다!

goto PRINT
)

goto GETLIST


:: ================================================================================
:DELTRASH

cls

:: desktop.ini 파일 삭제
for /f "usebackq tokens=1 delims=" %%i in (`dir *.* /a-d /b /s`) do (
if %%~nxi==desktop.ini (
echo %%~dpnxi
)
)

echo.
set /p isDel=desktop.ini 파일을 삭제하시겠습니까?(y/n) : 
echo.

if !isDel!==y (
del /s "desktop.ini"
) else (
echo 삭제되지 않았습니다.
)

:: ==========
echo.
:: .url 파일 삭제
set /p isDel=.url파일을 삭제하시겠습니까?(y/n) : 
echo.

if !isDel!==y (
del /s "*.url"
) else (
echo 삭제되지 않았습니다.
)

:: ==========
echo.
:: .txt 파일 삭제
for /f "usebackq tokens=1 delims=" %%i in (`dir *.* /a-d /b /s`) do (
if %%~xi==.txt (
echo %%~dpnxi
)
)

echo.
set /p isDel=.txt파일을 삭제하시겠습니까?(y/n) : 
echo.

if !isDel!==y (
del /s "*.txt"
) else (
echo 삭제되지 않았습니다.
)

:: ==========

pause

goto GETLIST

:: ================================================================================

:NUMBERSORT

set /p selectNS=현재 디렉토리의 노래 파일의 숫자를 정리하시겠습니까?(y/n) : 

if !selectNS!==y (
setlocal disabledelayedexpansion

call "!startPath!\!MusicSortProgram!" "%cd%"

setlocal enabledelayedexpansion

goto GETLIST
) else ( goto GETLIST )

:: ================================================================================

:ALLNUMBERSORT

set /p selectNS=모든 디렉토리의 노래 파일의 숫자를 정리하시겠습니까?(y/n) : 

if !selectNS!==y (

setlocal disabledelayedexpansion

for /f "usebackq tokens=1 delims=" %%k in (`dir *.* /ad /b /s`) do (
if /i not %%~nxk==BK (
call "%startPath%\%AllMusicSortProgram%" %%k )
)
setlocal enabledelayedexpansion
pause
goto GETLIST
) else ( goto GETLIST )

:: ================================================================================

:NUMBERCHECK

set /p selectNC=모든 디렉토리의 노래 파일을 확인하시겠습니까?(y/n) : 

if !selectNC!==y (
set lastPath=%cd%

cls

setlocal disabledelayedexpansion

for /f "usebackq tokens=1 delims=" %%k in (`dir *.* /ad /b /s`) do (
if /i not %%~nxk==BK (
echo ====================
echo 경로 : "%%~fk"
echo ----- 목록 -----
for /f "usebackq tokens=1 delims=" %%l in (`dir "%%~fk\*.mp3" /a-d /b`) do (
echo %%~nxl
)
)
)

setlocal enabledelayedexpansion

echo.

pause

cd /d !lastPath!

goto GETLIST
) else ( goto GETLIST )

:: ================================================================================

:NUMBERSORTSPACE

set /p selectNS=현재 디렉토리의 노래 파일의 숫자를 정리하시겠습니까?(Space 구분)(y/n) : 

if !selectNS!==y (
setlocal disabledelayedexpansion

call "%startPath%\%MusicSortProgramSpace%" "%cd%"

setlocal enabledelayedexpansion

goto GETLIST
) else ( goto GETLIST )

:: ================================================================================

:ALLNUMBERSORTSPACE

set /p selectNS=모든 디렉토리의 노래 파일의 숫자를 정리하시겠습니까?(Space 구분)(y/n) : 

if !selectNS!==y (

setlocal disabledelayedexpansion

for /f "usebackq tokens=1 delims=" %%k in (`dir *.* /ad /b /s`) do (
if /i not %%~nxk==BK (
call "%startPath%\%AllMusicSortProgramSpace%" %%k
)
)

setlocal enabledelayedexpansion

goto GETLIST
) else ( goto GETLIST )

:: ================================================================================

:MOVEMP3

set /p selectMM=현재 디렉토리의 MP3 폴더 안의 파일을 꺼내겠습니까?(y/n) : 

if !selectMM!==y (

setlocal disabledelayedexpansion

call "%startPath%\%MoveMp3Program%" %cd%

setlocal enabledelayedexpansion

goto GETLIST
) else ( goto GETLIST )

:: ================================================================================

:CHECKMP3

setlocal disabledelayedexpansion

echo.
echo MP3 폴더 체크

for /f "usebackq tokens=1 delims=" %%k in (`dir *.* /ad /b /s`) do (
if /i %%~nxk==mp3 (
echo %%~dpnxk
)
)
echo MP3 폴더 체크가 끝났습니다.

setlocal enabledelayedexpansion

pause

goto GETLIST

:: ================================================================================

:LOOPMP3

setlocal disabledelayedexpansion

echo.

for /f "usebackq tokens=1 delims=" %%k in (`dir *.* /ad /b /s`) do (
if /i %%~nxk==mp3 (
call "%startPath%\%MoveMp3Program%" %%~dpnxk\..
)
)
pause

setlocal enabledelayedexpansion

goto GETLIST

:: ================================================================================

:COVER

setlocal disabledelayedexpansion

echo.
echo ================================================================================
echo Cover.jpg 목록
for /f "usebackq tokens=1 delims=" %%k in (`dir "cover.jpg" /a-d /b /s`) do (
echo %%~dpnxk
)
echo ================================================================================


setlocal enabledelayedexpansion

set /p selectCV=Cover.jpg 이름을 바꾸시겠습니까?(y/n) : 

if !selectCV!==y (

setlocal disabledelayedexpansion
call "%startPath%\%CoverRenameProgram%"
)
setlocal enabledelayedexpansion

goto GETLIST

:: ================================================================================

:BKFOLDER
setlocal disabledelayedexpansion

echo.
echo ================================================================================
echo BK(JPG) 폴더 목록
for /f "usebackq tokens=1 delims=" %%k in (`dir "bk(jpg)" /ad /b /s`) do (
echo %%~dpnxk
)
echo ================================================================================

endlocal

setlocal enabledelayedexpansion

set /p selectBK=BK(JPG) 폴더 이름을 바꾸시겠습니까?(y/n) : 

if !selectBK!==y (

setlocal disabledelayedexpansion

call "%startPath%\%BKRenameProgram%"
)

setlocal enabledelayedexpansion

goto GETLIST

:: ================================================================================
:SUBSORT

echo.

set /p selectSS=현재 디렉토리의 자막을 정리하시겠습니까?(y/n) : 

if !selectSS!==y (

setlocal disabledelayedexpansion

call "%startPath%\%SubSortProgram%" "%cd%"

setlocal enabledelayedexpansion

goto GETLIST
) else ( goto GETLIST )

:: ================================================================================
:EXIT

pause

endlocal