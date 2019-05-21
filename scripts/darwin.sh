#!/bin/bash

for file in $@; do
	osascript -e "display dialog \"File: $file\""
done
