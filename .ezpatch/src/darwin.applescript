-- darwin.applescript
-- run a bash script for every file supplied

on open filelist
	tell application "Finder"
		set dirnameFinder to get (container of (path to me)) as text
		set dirname to (the POSIX path of dirnameFinder)
		set script_path to dirname & ".ezpatch/scripts/darwin.sh"
	end tell

	repeat with x in filelist
		do shell script script_path & " " & quoted form of POSIX path of x
	end repeat
end open
