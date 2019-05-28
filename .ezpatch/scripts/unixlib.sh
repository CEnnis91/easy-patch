#!/bin/bash
# unixlib.sh

BIN_DIR="${BASE_DIR}/.ezpatch/bin/$(uname | awk '{print tolower($0)}')"
NOTIF_NAME="Easy Patch"
# shellcheck disable=SC2034
PATCH_DIR="${BASE_DIR}/patches"
PROPERTIES="${SELF_DIR}/patch.properties"
# shellcheck disable=SC2034
UCON64="${BIN_DIR}/ucon64"
# shellcheck disable=SC2034
XDELTA3="${BIN_DIR}/xdelta3"

get_prop() {
	grep "^${1}=" "$PROPERTIES" | cut -d'=' -f2
}

md5sum_file() {
    if [[ "$(uname)" == "Darwin" ]]; then
        md5 "$1" | awk '{print $NF}'
    else
        md5sum "$1" | awk '{print $1}'
    fi
}

notify() {
    if [[ "$(uname)" == "Darwin" ]]; then
        osascript -e "display dialog \"${1}\" with title \"${NOTIF_NAME}\" buttons {\"OK\"}"
    else
        notify-send -u critical "${NOTIF_NAME}" "${1}"
    fi
}
