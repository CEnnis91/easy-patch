; win32.au3
; run a batch file for every file supplied
 
$DIRNAME = @ScriptDir & '\.ezpatch\scripts\'
$SCRIPT_PATH = $DIRNAME & 'win32.bat'
 
For $x = 1 To $CmdLine[0]
   ShellExecuteWait($SCRIPT_PATH, $CmdLine[$x], "", "", @SW_HIDE)
Next
