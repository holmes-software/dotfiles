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
Usage: steam-args.sh [-i|--itm] [-f|--force] [-h|--help]

Builds gamescope launch args with HDR support for Steam and copies them to the clipboard.

Options:
  -i, --itm     Include --hdr-itm-enabled in the args.
  -f, --force   Include --force-grab-cursor in the args.
  -h, --help    Show this help message and exit.
EOF
}

itm=0
force=0

while [[ $# -gt 0 ]]; do
    case "$1" in
        -i|--itm)
            itm=1
            shift
            ;;
        -f|--force)
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

itm_arg=""
if [[ "$itm" -eq 1 ]]; then
    itm_arg=" --hdr-itm-enabled"
fi

force_arg=""
if [[ "$force" -eq 1 ]]; then
    force_arg=" --force-grab-cursor"
fi

args="LD_PRELOAD=\"\" PROTON_ENABLE_WAYLAND=1 PROTON_ENABLE_HDR=1 gamescope -w 3440 -h 1440 -f -r 175 --hdr-enabled${itm_arg}${force_arg} -- env LD_PRELOAD=\"\${LD_PRELOAD}\" %command%"

wl-copy "${args}"
echo -e "${args}\nCopied to clipboard!"
