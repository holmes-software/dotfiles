#!/usr/bin/env bash
#  ____  _                            _                  
# / ___|| |_ ___  __ _ _ __ ___      / \   _ __ __ _ ___ 
# \___ \| __/ _ \/ _` | '_ ` _ \    / _ \ | '__/ _` / __|
#  ___) | ||  __/ (_| | | | | | |  / ___ \| | | (_| \__ \
# |____/ \__\___|\__,_|_| |_| |_| /_/   \_\_|  \__, |___/
#                                              |___/     
# ----------------------------------------------------- 
#
# Build the Steam launch args for gamescope and copy them to the clipboard.

set -euo pipefail

usage() {
    cat <<EOF
Usage: steam-args.sh (--hdr|--no-hdr) [-f] [-h|--help]

Builds gamescope launch args for Steam and copies them to the clipboard.

Required (one of):
  --hdr         Include --hdr-enabled in the args.
  --no-hdr      Include --hdr-itm-enabled in the args.
                If neither is supplied, you will be prompted (y|n).

Options:
  -f            Include --force-grab-cursor in the args. Simply exclude if not desired.
  -h, --help    Show this help message and exit.
EOF
}

hdr=""
force=0

while [[ $# -gt 0 ]]; do
    case "$1" in
        --hdr)
            hdr="yes"
            shift
            ;;
        --no-hdr)
            hdr="no"
            shift
            ;;
        -f)
            force=1
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown argument: $1" >&2
            usage >&2
            exit 1
            ;;
    esac
done

if [[ -z "$hdr" ]]; then
    while true; do
        read -r -p "Enable HDR? (y|n): " reply
        case "$reply" in
            y|Y) hdr="yes"; break ;;
            n|N) hdr="no"; break ;;
            *)   echo "Please answer y or n." >&2 ;;
        esac
    done
fi

if [[ "$hdr" == "yes" ]]; then
    hdr_arg="--hdr-enabled"
else
    hdr_arg="--hdr-itm-enabled"
fi

force_arg=""
if [[ "$force" -eq 1 ]]; then
    force_arg=" --force-grab-cursor"
fi

args="LD_PRELOAD=\"\" PROTON_ENABLE_WAYLAND=1 PROTON_ENABLE_HDR=1 gamescope -w 3440 -h 1440 -f -r 175 ${hdr_arg}${force_arg} -- env LD_PRELOAD=\"\${LD_PRELOAD}\" %command%"

wl-copy "${args}"
echo -e "${args}\nCopied to clipboard!"
