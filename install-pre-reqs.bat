@ECHO off
SETLOCAL

:: Set some defaults.
SET "SCRIPT_NAME=%~nx0"
SET "VSCODE_SCRIPT=%LOCALAPPDATA%\Programs\Microsoft VS Code\bin\code.cmd"
SET "VSCODE_INSTALL_EXE=VSCodeUserSetup-x64.exe"
SET "VSCODE_DOWNLOAD_URL=https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"

CALL :fail_if_not_running_as_admin || GOTO :error_exit
CALL :ensure_hosts_file_has_our_entries || GOTO :error_exit
CALL :ensure_vscode_installed || GOTO :error_exit
CALL :ensure_vscode_extensions_installed || GOTO :error_exit
ECHO Script %~nx0 completed successfully.
PAUSE
GOTO :eof

::------------------------------------------------------------------------------
:: Function definitions.
::------------------------------------------------------------------------------

:fail_if_not_running_as_admin
  net session >nul 2>&1
  IF %ERRORLEVEL% NEQ 0 (
    ECHO Error: Please run this %SCRIPT_NAME% from a "Run as Administrator" command prompt. >&2
    EXIT /B 1
  )
  EXIT /B 0

:ensure_hosts_file_has_our_entries
  SET "HOSTS_FILE=%WINDIR%\system32\drivers\etc\hosts"
  SETLOCAL ENABLEDELAYEDEXPANSION
  SET "HOSTS_FILE_NEEDS_CHANGES=false"
  SET "HOSTS_TO_ADD=i2analyze.eia postgres.eia prometheus.eia solr1.eia sqlserver.eia"
  FOR %%H IN (%HOSTS_TO_ADD%) DO (
    FIND /C /I "%%H" !HOSTS_FILE! >nul 2>nul
    IF !ERRORLEVEL! NEQ 0 (
      SET "HOSTS_FILE_NEEDS_CHANGES=true"
    )
  )
  IF !HOSTS_FILE_NEEDS_CHANGES! == true (
    (
      ECHO.
      ECHO # Added by %SCRIPT_NAME% at %DATE% %TIME%
    ) >>!HOSTS_FILE! || EXIT /B 1
    FOR %%H IN (%HOSTS_TO_ADD%) DO (
      FIND /C /I "%%H" !HOSTS_FILE! >nul 2>nul
      IF !ERRORLEVEL! NEQ 0 (
        (
          ECHO 127.0.0.1 %%H
        ) >>!HOSTS_FILE! || EXIT /B 1
        ECHO Added "127.0.0.1 %%H" to file "!HOSTS_FILE!".
      )
    )
  ) ELSE (
    ECHO File "!HOSTS_FILE!" was not changed; it already contained the necessary hostname entries.
  )
  ENDLOCAL
  EXIT /B 0

:ensure_vscode_installed
  IF EXIST "%VSCODE_SCRIPT%" (
    ECHO VSCode is already installed.
    EXIT /B 0
  )
  ECHO Download and install VSCode manually before reruning this script again.
  EXIT /B 1

:ensure_vscode_extension_installed
  :: Note: We have to CALL the VSCode command instead of merely invoking it.
  :: Invoking a Windows batch file from a Windows batch file *without* CALL
  :: is like unix "exec"; it will replace the current process with the new
  :: and never return back here.
  CALL "%VSCODE_SCRIPT%" --install-extension %1 --force
  IF %ERRORLEVEL% NEQ 0 (
    ECHO Error: Failed to install extension %1. >&2
    EXIT /B 1
  )
  :: no need to declare success using ECHO, as VSCode says enough itself.
  EXIT /B 0

:ensure_vscode_extensions_installed
  ECHO Ensuring necessaru VSCode extensions are installed...
  CALL :ensure_vscode_extension_installed ms-vscode-remote.remote-containers || EXIT /B 1
  CALL :ensure_vscode_extension_installed ms-vscode-remote.remote-wsl || EXIT /B 1
  ECHO VSCode extensions are installed
  EXIT /B 0

:error_exit
  ECHO Error: Script %SCRIPT_NAME% failed, code %ERRORLEVEL%
  PAUSE
  GOTO :eof
