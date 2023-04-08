#!/bin/sh
# Script made by OldWorldOrder
# Retina iFile icon made by meesebyte on Deviantart

rootcheck() {
    if [ "$(id -u)" -ne 0 ]; then
        printf "This script must be run as root!\n"
        exit 1
    fi
}

curlcheck() {
    if ! command -v curl > /dev/null; then
        printf "curl could not be found."
        exit 1
    fi
}

fixifile() {
    rootcheck
    curlcheck
    if [ -d /Applications/iFile.app ]; then
        printf "Removing old iFile icon...\n"
        rm -f /Applications/iFile.app/AppIcon*
        printf "Downloading new icon...\n"
        curl -s -o /Applications/iFile.app/Icon.png https://i.imgur.com/ZFhor.png
    else
        printf "iFile not found - Skipping...\n"
    fi
}

fixmterminal() {
    rootcheck
    curlcheck
    if [ -d /Applications/MTerminal.app ]; then
        printf "Removing old MTerminal icon...\n"
        rm -f /Applications/MTerminal.app/icon*
        printf "Downloading new icon...\n"
        curl -s -o /Applications/MTerminal.app/icon-76.png https://cydia.saurik.com/icon@2x/com.officialscheduler.mterminal.png
    else
        printf "MTerminal not found - Skipping...\n"
    fi
}

case $* in
    -h|--help)
        printf "iconfix - Fix the broken iFile and MTerminal icons on iOS 6 and below.

Usage: iconfix [OPTION]

    -h, --help              Print this message
    -v, --version           Display version info
        --ifile             Fix only iFile icon
        --mterminal         Fix only MTerminal icon\n"
        exit 0
    ;;

    -v|--version)
        printf "iconfix 5.1\n"
        exit 0
    ;;

    --ifile)
        fixifile
        printf "Done.\n"
        exit 0
    ;;

    --mterminal)
        fixmterminal
        printf "Done.\n"
        exit 0
    ;;
esac

fixifile
fixmterminal
printf "Done.\n"
