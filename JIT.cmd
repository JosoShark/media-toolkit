@echo off

:setup
:: file options
set file_input=
set file_output=
set file_dir=
set file_framerate=-1
set file_width=
set file_height=
set file_quality=
set file_loop=0
:: misc
set app_name=Joso's Image Toolkit


:main_menu
cd %~dp0 && cls && title %app_name%
::
echo [1] GIF Tools
echo [2] APNG Tools
echo [3] Credits
echo [4] Exit
echo ---------------
::
choice /C 1234
if %errorlevel% == 3 goto credits
if %errorlevel% == 2 goto apng_menu
if %errorlevel% == 1 goto gif_menu
exit


:credits
cls
echo Written by Joso_Shark
echo ---------------------
echo Software used:
echo  apngasm64 - http://apngasm.sourceforge.net
echo  ffmpeg    - https://ffmpeg.org
echo  gif2apng  - http://gif2apng.sourceforge.net
echo  gifski    - https://gif.ski
echo ---------------------
pause && goto main_menu


:apng_menu
cd %~dp0 && cls && title %app_name% - APNG Tools
::
echo [1] GIF to APNG
echo [2] Decompile
echo [3] Compile
echo [4] Main Menu
echo ---------------
::
choice /C 12345
if %errorlevel% == 4 goto main_menu
if %errorlevel% == 3 goto assembly
if %errorlevel% == 2 goto apng_assembly
if %errorlevel% == 1 goto apng_gif2apng
exit 


:apng_assembly


:apng_gif2apng


:gif_menu
cd %~dp0 && cls && title %app_name% - GIF Tools
::
echo [1] Video to GIF
echo [2] Decompile
echo [3] Compile
echo [4] Main Menu
echo ---------------
::
choice /C 12345
if %errorlevel% == 4 goto main_menu
if %errorlevel% == 3 goto gif_compile 
if %errorlevel% == 2 goto disassembly
if %errorlevel% == 1 goto gif_vid2gif
exit


:gif_vid2gif


:gif_compile


:cleanup
cls
if %clean% == 1 del /Q %~dp0\frames\temp_frames\*.png
if %clean_dir% == 1 del /Q %~dp0\frames\%file_dir%\*.png && rmdir /Q %~dp0\frames\%file_dir%
goto main_menu
exit