#!/bin/bash

#  b2d.command
#  Boot2Docker GUI
#
#  Created by Rimantas on 08/02/2014.
#  Copyright (c) 2014 Rimantas Mocevicius. All rights reserved.

SSH_PORT=2022
SSHFS=/usr/local/bin/sshfs

# get first argument - start, stop ...

if [ "$1" = "delete" ]
then
  # unmount remote share folder
  umount -f  ~/b2d-share
  ~/bin/boot2docker stop
elif [ "$1" = "restart" ]
then
  # unmount remote share folder
  umount -f  ~/b2d-share
elif [[ "$1" = "stop" || "$1" = "pause" ]]
then
  # unmount remote share folder
  umount -f  ~/b2d-share
fi

~/bin/boot2docker $1

if [ -f "$SSHFS" ]
then
  if [[ "$1" = "up" || "$1" = "restart" ]]
 then
    # make the folder b2d-share in user's home folder
    mkdir ~/b2d-share
    # create a remote share folder if it already does not exist
    ~/bin/sshpass -f ~/.boot2docker/b2d-passwd  ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p $SSH_PORT docker@localhost sudo mkdir /mnt/sda1/b2d-share
    # chown share folder by docker user and group
    ~/bin/sshpass -f ~/.boot2docker/b2d-passwd ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p $SSH_PORT docker@localhost sudo chown -R docker:docker /mnt/sda1/b2d-share
    # mount it localy to ~/b2d-share
    $SSHFS docker@localhost:/mnt/sda1/b2d-share ~/b2d-share -oping_diskarb,volname=b2d-share -p $SSH_PORT -o reconnect -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o password_stdin < ~/.boot2docker/b2d-passwd
  fi
fi


