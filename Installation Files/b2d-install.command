#!/bin/bash

#  b2d-install.command
#  Boot2Docker GUI
#
#  Created by Rimantas on 08/02/2014.
#  Copyright (c) 2014 Rimantas Mocevicius. All rights reserved.

# make the ".boot2docker" config folder  at user's home folder and setup the "profile" file there
mkdir ~/.boot2docker

# create bott2docker "profile" file
cp ./profile  ~/.boot2docker

# create and set "bin" folder path and docker environment in .bash_profile
mkdir ~/bin
DHOST=`export -p | grep -v grep  | grep DOCKER_HOST | cut -f 1 -d " "`
PBIN=`export -p | grep -v grep  | grep ~/bin | cut -f 1 -d " "`

if [ "$DHOST" = "" ]
then
  cat ./bash_profile_docker >> ~/.bash_profile
fi

if [ "$PBIN" = "" ]
then
  cat ./bash_profile_bin >> ~/.bash_profile
fi
###

# make the folder b2d-share in user's home folder
mkdir ~/b2d-share

# copy sshpass file
cp ./sshpass ~/bin
chmod +x ~/bin/sshpass

# create b2d-passwd file
echo "tcuser" > ~/.boot2docker/b2d-passwd

# download latest boot2docker OS script version
curl https://raw.github.com/boot2docker/boot2docker/master/boot2docker > ~/bin/boot2docker
# Mark it executable
chmod +x ~/bin/boot2docker

# run boot2docker init command
~/bin/boot2docker init

# download latest docker OS X client
curl -o ~/bin/docker http://get.docker.io/builds/Darwin/x86_64/docker-latest
# Mark it executable
chmod +x ~/bin/docker

# create short "b2d" symbolic link to "boot2docker", it makes easier to use via command line
ln -s ~/bin/boot2docker ~/bin/b2d

# copy main app to the Desktop
cp -r "Boot2Docker GUI.app" ~/Desktop

echo "Boot2Docker GUI Install is finished !!!"
