@echo off
setlocal

:: Define log file path
set LOGFILE=%~dp0youtube_control_log.log

:: Function to write log with timestamp
:log
echo [%date% %time%] %~1 >> %LOGFILE%
goto :eof

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
    call :log "Attempting to unblock YouTube."
    findstr /v /i "youtube.com" "%HOSTSFILE%" > "%HOSTSFILE%.tmp"
    if errorlevel 1 (
        call :log "ERROR: Failed to unblock YouTube."
    ) else (
        move /y "%HOSTSFILE%.tmp" "%HOSTSFILE%"
        if errorlevel 1 (
            call :log "ERROR: Failed to replace hosts file."
        ) else (
            call :log "SUCCESS: YouTube unblocked."
        )
    )
) else (
    echo Blocking YouTube...
    call :log "Attempting to block YouTube."
    >> %HOSTSFILE% echo 127.0.0.1 www.youtube.com
    >> %HOSTSFILE% echo 127.0.0.1 youtube.com
    if errorlevel 1 (
        call :log "ERROR: Failed to block YouTube."
    ) else (
        call :log "SUCCESS: YouTube blocked."
    )
)

echo Done.
call :log "Script execution completed."
endlocal
