@echo off

:: folder check
if not exist "%~dp0" (
  goto test
  )

goto menu

:test
echo tach
pause
