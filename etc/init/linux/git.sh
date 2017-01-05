#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# If you don't have git or don't find git preserved
# in a directory with the path,
# to install it after the platforms are detected
if ! has "git"; then

    # Install git
    if has "yum"; then
        log_echo "Install git with Yellowdog Updater Modified"
        sudo yum -y install git
    elif "apt"; then
        log_echo "Install git with Advanced Packaging Tool"
        sudo apt -y install git
    else
        log_fail "error: require: YUM or APT"
        exit 1
    fi
    ;;
fi

log_pass "git: installed successfully"
