@echo off 

:param_fenetre
title vider file impression
mode con cols=60 lines=20
color 9F

:demande_UAC
:-------------------------------------
REM  -->  Verification des permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> Erreur vous ne possedez pas les droits admin
if '%errorlevel%' NEQ '0' (
    echo Verification des privileges administrateur
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "%~s0", "%params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

cls
echo Arret du spouleur d'impression
	@echo off
	net stop spooler
echo attente...
	@echo off
	ping 127.0.0.1 -n 5 > NUL 2>&1
echo.
echo Nettoyage de la file d'impression
	del %systemroot%\System32\spool\printers\* /Q /F /S
echo nettoyage OK
echo.
echo Demarrage du spouleur d'impression
	@echo off
	net start spooler
echo.
	ping 127.0.0.1 -n 5 > NUL 2>&1