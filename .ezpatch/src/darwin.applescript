-- darwin.applescript
-- run a bash script for every file supplied

on open filelist
	tell application "Finder"
		if exists Finder window 1 then
			set dirnameFinder to target of Finder window 1 as text
		else
			set dirnameFinder to desktop as text
		end if

		set dirname to (the POSIX path of dirnameFinder)
		set script_path to dirname & ".ezpatch/scripts/darwin.sh"
	end tell

	repeat with x in filelist
		do shell script script_path & " " & quoted form of POSIX path of x
	end repeat
end open
