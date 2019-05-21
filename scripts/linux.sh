#!/bin/bash

for file in $@; do
	notify-send "File: $file"
done
