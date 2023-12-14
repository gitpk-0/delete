@echo off
setlocal EnableDelayedExpansion

:: Define log file path
set LOGFILE=%~dp0youtube_control.log

:: Log script start
echo [%date% %time%] Script started. >> %LOGFILE%

:: Get the current hour and AM/PM part
for /f "tokens=1-2 delims=: " %%a in ('time /t') do (
    set currenthour=%%a
    set ampm=%%b
)
echo [%date% %time%] Current hour is %currenthour% and ampm is %ampm%. >> %LOGFILE%

:: Convert hour to number for comparison (removing leading zero if present)
set /a currenthour=1%currenthour% %% 100
echo [%date% %time%] Converted hour: %currenthour%. >> %LOGFILE%

:: Define the path to the hosts file. This is where the YouTube URLs will be blocked/unblocked.
set HOSTSFILE=%windir%\System32\drivers\etc\hosts
echo [%date% %time%] Hosts file path is set to %HOSTSFILE%. >> %LOGFILE%

:: Check if the current time is between 2 PM and 3 PM.
if %currenthour%==2 if "%ampm%"=="PM" (
    echo [%date% %time%] Current time is between 2 PM and 3 PM. >> %LOGFILE%
    echo [%date% %time%] Attempting to unblock YouTube. >> %LOGFILE%
) else (
    echo [%date% %time%] Current time is not between 2 PM and 3 PM. >> %LOGFILE%
    echo [%date% %time%] Attempting to block YouTube. >> %LOGFILE%
)

:: Log script end
echo [%date% %time%] Script execution completed. >> %LOGFILE%
endlocal
