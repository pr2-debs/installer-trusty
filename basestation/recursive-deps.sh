#!/bin/bash

# Update package lists
rm deplist.pkgs
./fetch
./repocheck release basestation-release.yaml --path install_dev1/pr2-packages --gen 0.9.0
./verifyinstaller

# Copy the deplist.pkgs
scp deplist.pkgs dash@dev-vm-packages-01:/var/repos/pr2-dev-internal/ubuntu/conf/
ssh -t -t dash@dev-vm-packages-01 'bash -s' < recursive-deps2.sh
