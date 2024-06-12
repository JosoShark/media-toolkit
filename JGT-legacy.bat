@echo off

:setup
set window_title="Joso's Image Toolset" 
set file_input=
set file_output=
set file_framerate=-1
set file_width=
set file_height=
set file_quality=
set file_loop=0
set file_dir=

::checkup
cd %~dp0
set checkup_ffmpeg=OK
set checkup_ffprobe=OK
set checkup_gifski=OK
set checkup_gif2apng=OK
if not exist ffmpeg.exe (set checkup_ffmpeg=ERROR)
if not exist ffprobe.exe (set checkup_ffprobe=ERROR)
if not exist gifski.exe (set checkup_gifski=ERROR)
if not exist gif2apng.exe (set checkup_gif2apng=ERROR)
if not %checkup_ffmpeg% == OK goto setup_error
if not %checkup_ffprobe% == OK goto setup_error
if not %checkup_gifski% == OK goto setup_error
if not %checkup_gif2apng% == OK goto setup_error
goto main_menu
exit

:setup_error
title Joso's Image Toolset - Error!
echo ffmpeg.exe [%checkup_ffmpeg%]
echo ffprobe.exe [%checkup_ffprobe%]
echo gifski.exe [%checkup_gifski%]
echo gif2apng.exe [%checkup_gif2apng%]
pause
exit

:main_menu
cls
echo [1] convert to GIF
echo [2] extract frames
echo [3] manual stitching
echo [4] GIF to APNG
echo [5] credits 
echo [6] exit
choice /C 123456 
if %errorlevel% == 6 exit
if %errorlevel% == 5 goto credits
if %errorlevel% == 4 goto apng_convert
if %errorlevel% == 3 goto stitch_frames_setup
if %errorlevel% == 2 goto extract_frames_setup
if %errorlevel% == 1 goto convert_setup 
exit

:credits
cls
echo Script written by Joso Shark
echo ----------------------------
echo Programs used:
echo - FFmpeg https://ffmpeg.org
echo - Gifski https://gif.ski
pause
goto main_menu
exit

:convert_setup
cls
cd %~dp0\input
echo use [TAB] to select
set /P file_input= input filename:
cd %~dp0\output
set /P file_output= output filename:
cd %~dp0
echo detected framerate (frames/seconds)
ffprobe -v error -select_streams v -of default=noprint_wrappers=1:nokey=1 -show_entries stream=r_frame_rate input\%file_input%
set /P file_framerate= output framerate:
echo detected dimension (width x height)
ffprobe -v error -show_entries stream=width,height -of csv=p=0:s=x input\%file_input%
set /P file_width= output width:
set /P file_height= output height:
set /P file_quality= conversion quality (1-100):
cls
echo ---------=[Input]=-----------
echo %file_input%
echo ---------=[Output]=----------
echo name: %file_output%
echo framerate: %file_framerate%
echo width: %file_width%
echo height: %file_height%
echo quality: %file_quality%
echo -----------------------------
choice /C YN /M "correct?" 
if %errorlevel% == 2 goto convert_setup
if %errorlevel% == 1 goto converter
exit

:converter
cd %~dp0
ffmpeg -i input\%file_input% -r %file_framerate% frames\temp_frames\frame%%04d.png
timeout 1 >nul
cls 
gifski -o output\%file_output% --fps %file_framerate% --quality %file_quality% --width %file_width% --height %file_height% --repeat %file_loop% frames\temp_frames\frame*.png
goto cleanup
exit

:extract_frames_setup
cls
cd %~dp0\input
echo use [TAB] to select
set /P file_input= input filename:
cd %~dp0
echo detected framerate (frames/seconds)
ffprobe -v error -select_streams v -of default=noprint_wrappers=1:nokey=1 -show_entries stream=r_frame_rate input\%file_input% 
set /P file_framerate= output framerate:
cls
echo input: %file_input%
echo framerate: %file_framerate%
echo -----------------------------
choice /C YN /M "correct?" 
if %errorlevel% == 2 goto extract_frames_setup
if %errorlevel% == 1 goto extract_frames
exit

:extract_frames
mkdir frames\%file_input%
ffmpeg -i input\%file_input% -r %file_framerate% frames\%file_input%\frame%%04d.png
cls
choice /C YN /M "stitch frames?" 
if %errorlevel% == 2 goto main_menu
if %errorlevel% == 1 goto stitch_frames_setup
exit

:stitch_frames_setup
cls
cd %~dp0\frames
echo use [TAB] to select
dir
set /P file_dir= input directory:
cd %~dp0\output
cls
echo use [TAB] to select
dir
set /P file_output= output filename:
cd %~dp0
::detect if framerate has been set or not, with options
if not %file_framerate% == -1 (choice /C YN /M "keep framerate? ("%file_framerate%")") else (set /P file_framerate= output framerate:)
if %errorlevel% == 2 set /P file_framerate= output framerate:
set /P file_width= output width:
set /P file_height= output height:
set /P file_quality= conversion quality (1-100):
cls
echo ---------=[Output]=----------
echo name: %file_output%
echo framerate: %file_framerate%
echo width: %file_width%
echo height: %file_height%
echo quality: %file_quality%
echo -----------------------------
choice /C YN /M "correct?" 
if %errorlevel% == 2 goto stitch_frames_setup
if %errorlevel% == 1 goto stitch_frames
exit

:stitch_frames
gifski -o output\%file_output% --fps %file_framerate% --quality %file_quality% --width %file_width% --height %file_height% --repeat %file_loop% %~dp0\frames\%file_dir%\frame*.png
cls
choice /C YN /M "delete "%file_dir%" directory?"
if %errorlevel% == 2 goto main_menu
if %errorlevel% == 1 goto cleanup_dir
exit

:apng_convert
cls
cd %~dp0\output
echo use [TAB] to select
dir
set /P file_input= input file:
set /P file_output= output filename:
cd %~dp0
cls
echo input: %file_input%
echo output: %file_output%
echo -----------------------------
choice /C YN /M "correct?" 
if %errorlevel% == 2 goto apng_convert
cls
gif2apng.exe %~dp0output\%file_input% %~dp0output\%file_output%
goto main_menu
exit

:cleanup
cls
del /Q %~dp0\frames\temp_frames\*.png
goto main_menu
exit

:cleanup_dir
cls
del /Q %~dp0\frames\%file_dir%\*.png
rmdir /Q %~dp0\frames\%file_dir%
goto main_menu
exit

:: 🦈