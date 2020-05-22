@echo off

setlocal enabledelayedexpansion
title ���� ���� ���α׷�

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

echo ���� ��� : %cd%
echo ================================================================================
echo ���� ���
dir *.* /a-d /b

echo ================================================================================
echo ���� ���
echo [0] : ���� ����

set num=0
for /f "usebackq tokens=1 delims=" %%g in (`dir *.* /ad /b`) do (
set /a num=num+1
set list[!num!]=%%g
echo [!num!] : %%~nxg
)

:: ================================================================================
:PRINT

echo ================================================================================
echo 0. ��� ���� 1. ���� �̵�
echo 11. ���� ���丮�� �뷡 ���� ���� 12. ��� ������ �뷡 ���� ���� 13. mp3 ���� üũ (16, 17 : Space ����)
echo 21. MP3 ���� üũ 22. MP3 �������� ���� ������ 23. ��� MP3 ���� ����
echo 31. ���� ���丮�κ��� �뷡 ���� ���� 32. Cover ���� 33. BK ���� ����
set /p select=41. �ڸ� ���� 99. ���� : 
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
set /p newPath=���ο� ��� : 
if exist !newPath! (
cd /d !newPath!

goto GETLIST
) else (
echo �߸��� ��θ� �Է��߽��ϴ�!

goto PRINT
)

:: ================================================================================
:MOVE
set /p moveIndex=���� ��ȣ : 

if !moveIndex! equ 0 (
cd /d ..
) else if !moveIndex! GEQ 0 (
if !moveIndex! LEQ !num! (
cd /d !list[%moveIndex%]!
) else (
echo �߸��� ���� �Է��߽��ϴ�!

goto PRINT
) ) else (
echo �߸��� ���� �Է��߽��ϴ�!

goto PRINT
)

goto GETLIST


:: ================================================================================
:DELTRASH

cls

:: desktop.ini ���� ����
for /f "usebackq tokens=1 delims=" %%i in (`dir *.* /a-d /b /s`) do (
if %%~nxi==desktop.ini (
echo %%~dpnxi
)
)

echo.
set /p isDel=desktop.ini ������ �����Ͻðڽ��ϱ�?(y/n) : 
echo.

if !isDel!==y (
del /s "desktop.ini"
) else (
echo �������� �ʾҽ��ϴ�.
)

:: ==========
echo.
:: .url ���� ����
set /p isDel=.url������ �����Ͻðڽ��ϱ�?(y/n) : 
echo.

if !isDel!==y (
del /s "*.url"
) else (
echo �������� �ʾҽ��ϴ�.
)

:: ==========
echo.
:: .txt ���� ����
for /f "usebackq tokens=1 delims=" %%i in (`dir *.* /a-d /b /s`) do (
if %%~xi==.txt (
echo %%~dpnxi
)
)

echo.
set /p isDel=.txt������ �����Ͻðڽ��ϱ�?(y/n) : 
echo.

if !isDel!==y (
del /s "*.txt"
) else (
echo �������� �ʾҽ��ϴ�.
)

:: ==========

pause

goto GETLIST

:: ================================================================================

:NUMBERSORT

set /p selectNS=���� ���丮�� �뷡 ������ ���ڸ� �����Ͻðڽ��ϱ�?(y/n) : 

if !selectNS!==y (
setlocal disabledelayedexpansion

call "!startPath!\!MusicSortProgram!" "%cd%"

setlocal enabledelayedexpansion

goto GETLIST
) else ( goto GETLIST )

:: ================================================================================

:ALLNUMBERSORT

set /p selectNS=��� ���丮�� �뷡 ������ ���ڸ� �����Ͻðڽ��ϱ�?(y/n) : 

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

set /p selectNC=��� ���丮�� �뷡 ������ Ȯ���Ͻðڽ��ϱ�?(y/n) : 

if !selectNC!==y (
set lastPath=%cd%

cls

setlocal disabledelayedexpansion

for /f "usebackq tokens=1 delims=" %%k in (`dir *.* /ad /b /s`) do (
if /i not %%~nxk==BK (
echo ====================
echo ��� : "%%~fk"
echo ----- ��� -----
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

set /p selectNS=���� ���丮�� �뷡 ������ ���ڸ� �����Ͻðڽ��ϱ�?(Space ����)(y/n) : 

if !selectNS!==y (
setlocal disabledelayedexpansion

call "%startPath%\%MusicSortProgramSpace%" "%cd%"

setlocal enabledelayedexpansion

goto GETLIST
) else ( goto GETLIST )

:: ================================================================================

:ALLNUMBERSORTSPACE

set /p selectNS=��� ���丮�� �뷡 ������ ���ڸ� �����Ͻðڽ��ϱ�?(Space ����)(y/n) : 

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

set /p selectMM=���� ���丮�� MP3 ���� ���� ������ �����ڽ��ϱ�?(y/n) : 

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
echo MP3 ���� üũ

for /f "usebackq tokens=1 delims=" %%k in (`dir *.* /ad /b /s`) do (
if /i %%~nxk==mp3 (
echo %%~dpnxk
)
)
echo MP3 ���� üũ�� �������ϴ�.

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
echo Cover.jpg ���
for /f "usebackq tokens=1 delims=" %%k in (`dir "cover.jpg" /a-d /b /s`) do (
echo %%~dpnxk
)
echo ================================================================================


setlocal enabledelayedexpansion

set /p selectCV=Cover.jpg �̸��� �ٲٽðڽ��ϱ�?(y/n) : 

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
echo BK(JPG) ���� ���
for /f "usebackq tokens=1 delims=" %%k in (`dir "bk(jpg)" /ad /b /s`) do (
echo %%~dpnxk
)
echo ================================================================================

endlocal

setlocal enabledelayedexpansion

set /p selectBK=BK(JPG) ���� �̸��� �ٲٽðڽ��ϱ�?(y/n) : 

if !selectBK!==y (

setlocal disabledelayedexpansion

call "%startPath%\%BKRenameProgram%"
)

setlocal enabledelayedexpansion

goto GETLIST

:: ================================================================================
:SUBSORT

echo.

set /p selectSS=���� ���丮�� �ڸ��� �����Ͻðڽ��ϱ�?(y/n) : 

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