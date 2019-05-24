; win32.au3
; run a batch file for every file supplied

#include <Crypt.au3>
#include <MsgBoxConstants.au3>

$DIRNAME = @ScriptDir & '\.ezpatch\scripts\'
$SCRIPT_PATH = $DIRNAME & 'win32.bat'

If $CmdLine[0] = 0 Then
   MsgBox($IDOK, "Easy Patch", "Drag your ROM onto this program")
EndIf

For $x = 1 To $CmdLine[0]
   $md5sum = _Crypt_HashFile($CmdLine[$x], $CALG_MD5)
   ShellExecuteWait($SCRIPT_PATH, $CmdLine[$x] & " " & $md5sum, "", "", @SW_HIDE)
Next
