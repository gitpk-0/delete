@echo off
setlocal

:: Get the current hour and AM/PM part
for /f "tokens=1,2 delims=: " %%a in ('time /t') do (
    set currenthour=%%a
    set ampm=%%b
)

:: Convert hour to number for comparison (removing leading zero if present)
set /a currenthour=1%currenthour% %% 100

:: Define hosts file path
set HOSTSFILE=%windir%\System32\drivers\etc\hosts

:: Check if current time is between 2 PM and 3 PM
if %currenthour%==2 if "%ampm%"=="PM" (
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
