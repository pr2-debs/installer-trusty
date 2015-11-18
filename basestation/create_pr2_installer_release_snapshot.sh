#!/bin/bash

#TODO add release number input from command line.

# Creation of snapshot of repos
sudo aptly snapshot create repo-trusty-base from repo trusty-base
sudo aptly snapshot create repo-trusty-desktop from repo trusty-desktop
sudo aptly snapshot create repo-trusty-basestation from repo trusty-basestation
sudo aptly snapshot create repo-trusty-pr2-ros from repo trusty-pr2-ros
sudo aptly snapshot create repo-trusty-pr2-debs from repo trusty-pr2-debs 
sudo aptly snapshot create repo-trusty-pr2-desktop from repo trusty-pr2-desktop 

# Merge snapshots to create repo release
sudo aptly snapshot merge trusty-release-0.9.2 repo-trusty-base repo-trusty-desktop repo-trusty-basestation repo-trusty-pr2-ros repo-trusty-pr2-debs repo-trusty-pr2-desktop
