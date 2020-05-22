@echo off

setlocal enabledelayedexpansion

chcp 65001 >nul

title Get Directory

dir %1\*.* /ad /b > new_dir.txt

chcp 949 >nul

endlocal
