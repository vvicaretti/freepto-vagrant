#!/bin/bash

# Can't mount shared folders with guest additions 4.3.10
# https://www.virtualbox.org/ticket/12879

if [ ! -L /usr/lib/VBoxGuestAdditions ]; then
    sudo ln -s /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions \
    /usr/lib/VBoxGuestAdditions
    echo "symlink /usr/lib/VBoxGuestAdditions created"
fi
