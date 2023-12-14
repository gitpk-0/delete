@echo off
setlocal

:: Get the current hour
for /f "tokens=1 delims=:" %%a in ('echo %time%') do set currenthour=%%a

:: Correct for single digit hours (leading space)
if "%currenthour:~0,1%" == " " set currenthour=0%currenthour:~1,1%

:: Convert to a number for comparison
set /a currenthour=%currenthour%

:: Define hosts file path
set HOSTSFILE=%windir%\System32\drivers\etc\hosts

:: Check if current time is between 14 (2 PM) and 15 (3 PM)
if %currenthour% geq 14 if %currenthour% lss 15 (
    echo Unblocking YouTube...
    :: Unblock YouTube: Remove YouTube lines from the hosts file
    findstr /v /i "youtube.com" "%HOSTSFILE%" > "%HOSTSFILE%.tmp"
    move /y "%HOSTSFILE%.tmp" "%HOSTSFILE%"
) else (
    echo Blocking YouTube...
    :: Block YouTube: Add YouTube lines to the hosts file
    echo 127.0.0.1 www.youtube.com >> %HOSTSFILE%
    echo 127.0.0.1 youtube.com >> %HOSTSFILE%
)

echo Done.
endlocal
