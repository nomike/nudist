#!/bin/sh

fail() {
    local message=$1
    local error_code=${2:-1}
    echo "$message" >&2
    exit $error_code
}

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    fail "This script must be run as root."
fi

# Check if the system is Ubuntu
if [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    if [ "$DISTRIB_ID" != "Ubuntu" ]; then
        fail "This script is intended for Ubuntu systems only."
    fi
else
    fail "Unable to determine the Linux distribution."
fi

# Check if git is already installed
if ! command -v git &> /dev/null; then
    # Install git
    sudo apt-get update
    sudo apt-get install -y git
fi
# Check if make is already installed
if ! command -v make &> /dev/null; then
    # Install make
    sudo apt-get install -y make
fi

# Create the coding directory
mkdir -p /root/coding

# Clone the nudist repository
git clone  https://github.com/nomike/nudist.git /root/coding/nudist

cd /root/coding/nudist

# Install the dependencies
make prereq

# Run nudist
make
