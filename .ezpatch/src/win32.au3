; win32.au3
; run a batch file for every file supplied

#include <Crypt.au3>
#include <MsgBoxConstants.au3>

$DIRNAME = @ScriptDir & '\.ezpatch\scripts\'
$NOTIF_NAME = 'Easy Patch'
$SCRIPT_PATH = $DIRNAME & 'win32.bat'

If $CmdLine[0] = 0 Then
   MsgBox($IDOK, $NOTIF_NAME, "Drag the appropriate ROM onto this program to patch it")
EndIf

For $x = 1 To $CmdLine[0]
   ; it is easier for autoit to grab the md5sum than let the batch file
   $md5sum = _Crypt_HashFile($CmdLine[$x], $CALG_MD5)
   $file = '"' & $CmdLine[$x] & '"'

   ShellExecuteWait($SCRIPT_PATH, $file & ' ' & $md5sum, "", "")
Next
