#!/bin/bash

# Check the Linux distribution
if [ -f /etc/os-release ]; then
    # Read the distribution information
    . /etc/os-release
    #DISTRO=$NAME
    DISTRO=$ID
elif [ -f /etc/os-release ]; then
    # Read the distribution information
    #. /etc/lsb-release
    . /etc/os-release
    #DISTRO=$DISTRIB_ID
    DISTRO=$ID_LIKE
else
    echo "Unknown Linux distribution"
    exit 1
fi

# Run commands based on the distribution
if [ "$DISTRO" == "debian" ] || [ "$DISTRO" == "ubuntu" ]; then
    # Commands for Ubuntu and Debian
    echo "
    ██████╗ ███████╗██████╗ ██╗ █████╗ ███╗   ██╗
    ██╔══██╗██╔════╝██╔══██╗██║██╔══██╗████╗  ██║
    ██║  ██║█████╗  ██████╔╝██║███████║██╔██╗ ██║
    ██║  ██║██╔══╝  ██╔══██╗██║██╔══██║██║╚██╗██║
    ██████╔╝███████╗██████╔╝██║██║  ██║██║ ╚████║
    ╚═════╝ ╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝
                                             "
    echo "Not yet supported " $DISTRO

elif [ "$DISTRO" == "fedora" ]; then
    # Commands for Fedora
    echo "
    ███████╗███████╗██████╗  ██████╗ ██████╗  █████╗ 
    ██╔════╝██╔════╝██╔══██╗██╔═══██╗██╔══██╗██╔══██╗
    █████╗  █████╗  ██║  ██║██║   ██║██████╔╝███████║
    ██╔══╝  ██╔══╝  ██║  ██║██║   ██║██╔══██╗██╔══██║
    ██║     ███████╗██████╔╝╚██████╔╝██║  ██║██║  ██║
    ╚═╝     ╚══════╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
                                                 "
    source $(pwd)/fedora/install.sh

elif [ "$DISTRO" == "arch" ]; then
    # Commands for Arch
    echo "
     █████╗ ██████╗  ██████╗██╗  ██╗
    ██╔══██╗██╔══██╗██╔════╝██║  ██║
    ███████║██████╔╝██║     ███████║
    ██╔══██║██╔══██╗██║     ██╔══██║
    ██║  ██║██║  ██║╚██████╗██║  ██║
    ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
                                    
    "
    source $(pwd)/arch/install.sh

else
    echo "Not yet supported " $DISTRO

fi