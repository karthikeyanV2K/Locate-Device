@echo off
echo Uninstalling Location Tracker...

:: Kill running process if exists
taskkill /F /IM "System-Location.exe" 2>nul

:: Remove startup entry
echo Removing startup entry...
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "LocationTracker" /f

:: Remove program files
echo Removing program files...
rd /s /q "C:\Program Files\Locate-Device" 2>nul

:: Remove Start Menu shortcut
rd /s /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Locate-Device" 2>nul

echo Uninstallation completed successfully!
timeout /t 5 