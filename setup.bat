@echo off
echo Location Tracker Setup
echo ====================

:: Check for admin rights
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running with administrator rights...
) else (
    echo Please run this script as Administrator!
    echo Right-click the script and select "Run as administrator"
    pause
    exit
)

:: Kill any existing instance
echo Stopping any running instances...
taskkill /F /IM "System-Location.exe" 2>nul
timeout /t 2 /nobreak >nul

:: Create program directory
echo Creating program directory...
mkdir "C:\Program Files\Locate-Device" 2>nul

:: Copy executable and dependencies
echo Copying program files...
copy /Y "%~dp0System-Location.exe" "C:\Program Files\Locate-Device\"

:: Create startup entry
echo Setting up autostart...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "LocationTracker" /t REG_SZ /d "C:\Program Files\Locate-Device\System-Location.exe" /f

:: Create uninstall shortcut in Start Menu
echo Creating uninstall shortcut...
mkdir "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Locate-Device" 2>nul
copy /Y "%~dp0uninstall.bat" "C:\Program Files\Locate-Device\"
echo @echo off > "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Locate-Device\Uninstall.bat"
echo cd /d "C:\Program Files\Locate-Device" >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Locate-Device\Uninstall.bat"
echo call uninstall.bat >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Locate-Device\Uninstall.bat"

echo.
echo Installation completed!
echo.

:: Start the program
echo Starting Location Tracker...
echo This window will close in 10 seconds...
echo Check your Telegram for location updates!
echo.
echo If you need to uninstall, go to:
echo Start Menu ^> Locate-Device ^> Uninstall
echo.

:: Start program and wait briefly
cd /d "C:\Program Files\Locate-Device"
start "" "System-Location.exe"

timeout /t 10
exit 