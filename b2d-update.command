#!/bin/bash

#  b2d-update.command
#  Boot2Docker GUI
#
#  Created by Rimantas on 08/02/2014.
#  Copyright (c) 2014 Rimantas Mocevicius. All rights reserved.


if [ "$1" = "docker" ]
then
    # download latest version docker file
    curl -o ~/bin/docker http://get.docker.io/builds/Darwin/x86_64/docker-latest
    # Mark it executable
    chmod +x ~/bin/docker

    ~/bin/docker version
fi

if [ "$1" = "script" ]
then
    # download latest boot2docker OS script version
    curl https://raw.github.com/boot2docker/boot2docker/master/boot2docker > ~/bin/boot2docker
    chmod +x ~/bin/boot2docker
fi

if [ "$1" = "iso" ]
then
    # stop boot2docker
    ~/bin/boot2docker stop

    # download latest version of boot2docker.iso file
    ~/bin/boot2docker download
fi


