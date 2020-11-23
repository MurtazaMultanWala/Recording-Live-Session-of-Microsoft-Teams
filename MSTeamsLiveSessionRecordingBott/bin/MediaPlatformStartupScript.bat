@echo off

REM Delete old MP service perf counters. We can remove the lines below once all users of our old SDK that registered AVMPPerf.dll have switched to using this script

echo Checking for Lync AVMP perf counters
reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AVMPPerf >nul 2>&1
if %errorlevel% equ 0 (
    echo Removing HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AVMPPerf key
    reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AVMPPerf /f || GOTO ERROR
)

echo Checking if dependent binaries are present
if not exist InstallMPServiceImpCounters.ps1 (
    echo Missing file InstallMPServiceImpCounters.ps1
    exit /B 1
)
if not exist MPServiceImp.dll (
    echo Missing file MPServiceImp.dll
    exit /B 1
)
if not exist MediaPerf.dll (
    echo Missing file MediaPerf.dll
    exit /B 1
)
if not exist MediaPerf.h (
    echo Missing file MediaPerf.h
    exit /B 1
)
if not exist MediaPerf.ini (
    echo Missing file MediaPerf.ini
    exit /B 1
)
REM Dependencies of MPServiceImp which is loaded in InstallMPServiceImpCounters
if not exist Microsoft.Rtc.Internal.Media.dll (
    echo Missing file Microsoft.Rtc.Internal.Media.dll
    exit /B 1
)
if not exist rtmpal.dll (
    echo Missing file rtmpal.dll
    exit /B 1
)

echo Installing MP service perf counters
powershell -ExecutionPolicy Bypass .\InstallMPServiceImpCounters.ps1 || GOTO ERROR

echo Installing MediaPerf.dll
regsvr32 /i /n /s MediaPerf.dll || GOTO ERROR

echo Successfully ran MediaPlatformStartupScript

:EXIT
EXIT /B 0

:ERROR
EXIT /B %ERRORLEVEL%