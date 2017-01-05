#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# If you don't have git or don't find git preserved
# in a directory with the path,
# to install it after the platforms are detected
# Install git
if has "yum"; then
    sudo yum -y install git
elif "apt"; then
    sudo apt -y install git
else
    exit 1
fi
