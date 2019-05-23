#!/bin/bash
# darwin.sh

SELF_DIR="$(cd "$(dirname "$0")"; pwd -P)"
BASE_DIR="$(dirname "$(dirname "$SELF_DIR")")"

export SELF_DIR
export BASE_DIR
. "${SELF_DIR}/unixlib.sh"

if [[ $# -lt 1 ]]; then
	exit 0
fi

FORMAT="$(get_prop 'format')"
MD5SUM="$(get_prop 'md5sum')"
OUTPUT_DIR="$(get_prop 'output')"
TMP_DIR="$(mktemp -d)"
TMP_ROM="${TMP_DIR}/input.rom"

for file in "$@"; do
	cp "$file" "$TMP_ROM"
	$UCON64 "--${FORMAT}" "$TMP_ROM"

	input_md5sum="$(md5 "$TMP_ROM" | awk '{print $NF}')"
	if [[ "$input_md5sum" == "$MD5SUM" ]]; then
		for patch in $PATCH_DIR/*; do
			patch_name="$(basename "$patch")"
			output_rom="${BASE_DIR}/${OUTPUT_DIR}/${patch_name%.*}.${FORMAT}"
			$XDELTA3 -d -f -s "$TMP_ROM" "$patch" "$output_rom"

			if [[ $? -eq 0 ]]; then
				notify "Successfully created $(basename "$output_rom") in $(dirname "$output_rom")"
			else
				notify "There was an error creating $(basename "$output_rom")"
			fi
		done
	else
		notify "Supplied ROM does not match the expected value"
	fi
done

rm -rf "$TMP_DIR"
exit 0
