@echo off
setlocal enabledelayedexpansion

REM Set UTF-8 encoding
chcp 65001 >nul

REM Set color codes (ANSI escape codes)
for /F %%a in ('"prompt $E & for %%b in (1) do rem"') do set "ESC=%%a"
set "NAME=%ESC%[32m"
set "CALL=%ESC%[33m"
set "COMMAND=%ESC%[36m"
set "RESET=%ESC%[0m"

REM Show usage and ASCII art if no arguments
if "%~1"=="" (

    echo Usage:
    echo   %CALL%repo%RESET% %COMMAND%-new%RESET% %NAME%project-name%RESET%
    echo   %CALL%repo%RESET% %COMMAND%-edit%RESET%
    echo   %CALL%repo%RESET% %COMMAND%-push%RESET%
    echo   %CALL%repo% %COMMAND%-commit%RESET% %NAME%message%RESET%
    echo   %CALL%repo% %COMMAND%-sync%RESET% %NAME%optional commit message%RESET%
    echo   %CALL%repo% %COMMAND%-clone%RESET% %NAME%repository-url%RESET%
    exit /b 1
)

REM Set commands folder
set "cmdfolder=%~dp0commands"

REM Handle commands
if "%1"=="-new" (
    shift
    call "%cmdfolder%\new.cmd" %*
    exit /b %errorlevel%
)

if "%1"=="-edit" (
    call "%cmdfolder%\edit.cmd"
    exit /b %errorlevel%
)

if "%1"=="-push" (
    shift
    call "%cmdfolder%\push.cmd" %*
    exit /b %errorlevel%
)

if "%1"=="-commit" (
    shift
    call "%cmdfolder%\commit.cmd" %*
    exit /b %errorlevel%
)

if "%1"=="-sync" (
    shift
    call "%cmdfolder%\sync.cmd" %*
    exit /b %errorlevel%
)

if "%1"=="-clone" (
    shift
    call "%cmdfolder%\clone.cmd" %2
    exit /b %errorlevel%
)

echo Unknown command: %1
exit /b 1
