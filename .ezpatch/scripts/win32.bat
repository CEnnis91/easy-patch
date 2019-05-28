:: win32.bat
@echo off

set SELF_DIR="%~dp0"
FOR /F "delims=" %%d IN ("%SELF_DIR:~1,-2%") DO ECHO %%d
FOR /F "delims=" %%d IN ("%SELF_DIR:~1,-2%") DO set SELF_PARENT_DIR="%%~dpd"
FOR /F "delims=" %%d IN ("%SELF_PARENT_DIR:~1,-2%") DO set BASE_DIR="%%~dpd"
set BIN_DIR="%BASE_DIR:"=%.ezpatch\bin\win32"
set PATCH_DIR="%BASE_DIR:"=%patches"

set PROPERTIES="%SELF_DIR:"=%patch.properties"
set UCON64="%BIN_DIR:"=%\ucon64.exe"
set XDELTA3="%BIN_DIR:"=%\xdelta3.exe"

:: <input file> <md5sum of input>
:: <input file> is already quoted from win32.au3
IF %1=="" EXIT 0
IF "%2"=="" EXIT 0

FOR /F "tokens=1* delims==" %%A IN ('type %PROPERTIES%') DO (
	IF "%%A"=="format" set FORMAT=%%B
	IF "%%A"=="md5sum" set MD5SUM=%%B
	IF "%%A"=="output" set OUTPUT_DIR=%%B
	IF "%%A"=="version" set VERSION=%%B
)
set TMP_ROM="%temp%\input.rom"

COPY "%1" %TMP_ROM%
%UCON64% "--%FORMAT%" %TMP_ROM%

:: by default AutoIt outputs 0xDEADBEEF, but properties has
:: just deadbeef, account for this format difference
IF /I "%2"=="0x%MD5SUM%" (
	FOR %%X IN ("%PATCH_DIR:"=%\*") DO (
		ECHO %%X | find ".gitignore" > nul

		IF errorlevel 1 (
			:: written this way to avoid delayed variable expansion
			%XDELTA3% -d -f -s %TMP_ROM% "%%X" "%BASE_DIR:"=%%OUTPUT_DIR%\%%~nX.%FORMAT%"

			IF errorlevel 0 (
				CALL :notify "Successfully created %%~nX.%FORMAT% in %BASE_DIR:"=%%OUTPUT_DIR%"
			) ELSE (
				CALL :notify "There was an error creating %%~nX"
			)
		)
	)
) || (
	CALL :notify "Your ROM does not match the developer's original ROM"
)

::PAUSE
DEL %TMP_ROM% /f /q
EXIT /B 0

:notify
ECHO x=msgbox("%~1", 0, "Easy Patch") > "%temp%\notify.vbs"
wscript.exe "%temp%\notify.vbs"
DEL "%temp%\notify.vbs" /f /q
EXIT /B 0
