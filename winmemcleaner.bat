@echo off

echo [*] some of the actions requires administer privilege
echo [?] do want to procede ?
call :ask
if errorlevel 1 (
    echo continuing...
) else (
    exit /b
)

echo [*] clean old versions and out-of-use for the current system components from  C:\Windows\WinSxS
call :ask
if errorlevel 1 (
    echo cleaning...
    echo Dism.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase
    Dism.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase
)


echo [*] squeeze %LOCALAPPDATA%\Docker\wsl\disk\docker_data.vhdx which only swells and doesnt reduces when deleting some image fro Docker
call :ask
if errorlevel 1 (
    echo cleaning...
    echo docker system prune -a --volumes
    docker system prune -a --volumes
)

echo [*] clean IntelliSense cache. these files are restored when opening project in vscode
call :ask
if errorlevel 1 (
    echo cleaning ...
    echo rmdir /s /q %LOCALAPPDATA%\Microsoft\vscode-cpptools
    rmdir /s /q %LOCALAPPDATA%\Microsoft\vscode-cpptools
    mkdir %LOCALAPPDATA%\Microsoft\vscode-cpptools
)

echo [*] clean crash logs from %TEMP%\DiagOutputDir, %TEMP%\wsl-crashes
call :ask
if errorlevel 1 (
    echo cleaning ...
    echo rmdir /s /q %TEMP%\DiagOutputDir
    rmdir /s /q %TEMP%\DiagOutputDir %TEMP%\wsl-crashes
)


exit /b

:ask
choice /C YN /M "%~1"
if errorlevel 2 exit /b 0
if errorlevel 1 exit /b 1