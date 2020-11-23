# Installs embedded MPServiceImp.dll ("AVMP") performance counters 
# If existing "System" shared performance counters in AVMPPerf.dll have been installed, they must be removed
# Check [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AVMPPerf]

if (test-path hklm:\SYSTEM\CurrentControlSet\Services\AVMPPerf)
{
    Write-Warning "Existing shared AVMP performance counter DLL must be uninstalled before installing custom embedded performance counters."
    Write-Host -ForegroundColor yellow -Object (Get-ChildItem -Path HKLM:\SYSTEM\CurrentControlSet\Services\AVMPPerf | Get-ItemProperty -Name "Library" |  Select-Object -Property Library)
    Write-Host -ForegroundColor yellow "Run this command: 'Remove-Item -Path HKLM:\SYSTEM\CurrentControlSet\Services\AVMPPerf -Confirm -Recurse'"
}
else
{
    # Beware that Import-Module will silently fail if run within the ISE as a non-admin. Check for this probable cause 
    # if you see an error message like "The term 'Add-MPServicePerformanceCounters' is not recognized ...." but no preceding error.

    Push-Location $PSScriptRoot
    Import-Module .\"MPServiceImp.dll"
    Remove-MPServicePerformanceCounters
    Add-MPServicePerformanceCounters
    Remove-Module -name MPServiceImp
    Pop-Location
}