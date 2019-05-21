on open filelist
	tell application "Finder"
		set dirnameOSX to get (container of (path to me)) as text
		set dirname to (the POSIX path of dirnameOSX)
	end tell

	set darwin_script to dirname & "scripts/darwin.sh"

	repeat with x in filelist
		do shell script darwin_script & " " & quoted form of POSIX path of x
	end repeat
end open
