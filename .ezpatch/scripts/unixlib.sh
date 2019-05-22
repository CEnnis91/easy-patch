#!/bin/bash
# unixlib.sh

BIN_DIR="${BASE_DIR}/.ezpatch/bin/$(uname | awk '{print tolower($0)}')"
NOTIF_NAME="Easy Patch"
PATCH_DIR="${BASE_DIR}/patches"
PROPERTIES="${SELF_DIR}/patch.properties"
UCON64="${BIN_DIR}/ucon64"
XDELTA3="${BIN_DIR}/xdelta3"

get_prop() {
	grep "^${1}=" "$PROPERTIES" | cut -d'=' -f2
}

notify() {
    if [[ "$(uname)" == "Darwin" ]]; then
        notifyDarwin "$1"
    else
        notifyLinux "$1"
    fi
}

notifyDarwin() {
    osascript -e "display dialog with title \"${NOTIF_NAME}\" \"${1}\" buttons {\"OK\"}"
}

notifyLinux() {
	notify-send --app-name="${NOTIF_NAME}" "${1}"
}
