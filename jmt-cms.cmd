@echo off

:: "Context Menu Selector" Version

:setup
title - %1
set file_input=
set file_output=
set file_framerate=-1
set file_width=
set file_height=
set file_quality=
set file_loop=0
set file_dir=


:context_menu
:: set file path
set file_input=%1

echo par: %1
echo filename: %~nx0
echo drive-path: %~dp0

:: remove "" and spaces
set file_input=%file_input: =_%
set file_input=%file_input:"=%
:: echo %file_input%
pause
goto main_menu


:main_menu
cls
echo [1] Convert
echo [2] Extract
echo [3] Assemble
echo [4] Exit
choice /C 1234
if %errorlevel% == 4 exit
if %errorlevel% == 3 goto compile_menu
if %errorlevel% == 2 goto extract_menu
if %errorlevel% == 1 goto convert_menu
exit



:compile_menu
cls
echo [1] 
echo [2] 
echo [3] 
echo [4] 
echo [5] Main Menu
choice /C 12345
if %errorlevel% == 5 goto main_menu
if %errorlevel% == 4 goto
if %errorlevel% == 3 goto 
if %errorlevel% == 2 goto 
if %errorlevel% == 1 goto
exit


:extract_menu
cls
echo [1] 
echo [2] 
echo [3] 
echo [4] 
echo [5] Main Menu
choice /C 12345
if %errorlevel% == 5 goto main_menu
if %errorlevel% == 4 goto
if %errorlevel% == 3 goto 
if %errorlevel% == 2 goto 
if %errorlevel% == 1 goto
exit


:convert_menu
cls
echo [1] -
echo [2] -
echo [3] -
echo [4] -
echo [5] Main Menu
choice /C 12345
if %errorlevel% == 5 goto main_menu
if %errorlevel% == 4 goto
if %errorlevel% == 3 goto 
if %errorlevel% == 2 goto 
if %errorlevel% == 1 goto
exit