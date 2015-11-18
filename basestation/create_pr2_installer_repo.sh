#!/bin/bash

sudo echo "deb http://repo.aptly.info/ squeeze main" >> /etc/apt/sources.list
sudo apt-get update
sudo apt-get install aptly
sudo gpg --no-default-keyring --keyring /usr/share/keyrings/ubuntu-archive-keyring.gpg --export | gpg --no-default-keyring --keyring trustedkeys.gpg --import

# ubuntu base packages mirror setup
sudo aptly mirror create -architectures=amd64 -filter='Priority (required) | Priority (important) | Priority (standard) | ubuntu-server' -filter-with-deps trusty-base http://us.archive.ubuntu.com/ubuntu trusty main universe multiverse restricted

# ubuntu desktop packages mirror setup
sudo aptly mirror create -architectures=amd64 -filter='Priority (required) | Priority (important) | Priority (standard) | ubuntu-desktop' -filter-with-deps trusty-desktop http://us.archive.ubuntu.com/ubuntu trusty main universe multiverse restricted

# pr2 ros packages mirror setup
sudo aptly mirror create -architectures=amd64 -filter='Priority (required) | Priority (important) | Priority (standard) | ros-indigo-pr2-simulator | ros-indigo-pr2-bringup | ros-indigo-pr2-robot | ros-indigo-pr2-navigation | ros-indigo-pr2-ethercat-drivers | ros-indigo-pr2-power-drivers | ros-indigo-wge100-driver | ros-indigo-wifi-ddwrt | ros-indigo-hokuyo-node | ros-indigo-prosilica-camera | ros-indigo-camera1394 | ros-indigo-linux-networking | ros-indigo-pr2-navigation-apps | ros-indigo-sicktoolbox | ros-indigo-sicktoolbox-wrapper | ros-indigo-joystick-drivers | ros-indigo-microstrain-3dmgx2-imu | ros-indigo-audio-common' -filter-with-deps trusty-pr2 http://packages.ros.org/ros/ubuntu trusty main

# pr2 desktop mirror setup
sudo aptly mirror create -architectures=amd64 -filter='Priority (required) | Priority (important) | Priority (standard) | ros-indigo-desktop-full | ros-indigo-pr2-ethercat-drivers | ros-indigo-rqt-pr2-dashboard | ros-indigo-pr2-simulator | ros-indigo-pr2-power-drivers | ros-indigo-pr2-navigation |ros-indigo-control-msgs | ros-indigo-geometry-experimental | ros-indigo-joystick-drivers | ros-indigo-mobile | ros-indigo-moveit-full-pr2 | ros-indigo-perception | ros-indigo-perception-pcl | ros-indigo-pr2-apps | ros-indigo-pr2-calibration | ros-indigo-pr2-common | ros-indigo-pr2-common-actions | ros-indigo-pr2-controllers | ros-indigo-pr2-kinematics | ros-indigo-pr2-mechanism | ros-indigo-ros-realtime | ros-indigo-sql-database | ros-indigo-warehouse-ros' -filter-with-deps trusty-pr2-desktop http://packages.ros.org/ros/ubuntu trusty main

# updating the mirrors
sudo aptly mirror update trusty-basestation
sudo aptly mirror update trusty-base
sudo aptly mirror update trusty-pr2-debs
sudo aptly mirror update trusty-pr2-ros
sudo aptly mirror update trusty-desktop
sudo aptly mirror update trusty-pr2-desktop

# creating repos from the mirrors 
sudo aptly repo create -comment="The PR2 server and basestation base packages for Trusty" -component="main" -distribution="trusty" trusty-base
sudo aptly repo create -comment="The Basestation Ubuntu desktop packages" -component="main" -distribution="trusty" trusty-desktop
sudo aptly repo create -comment="The Trusty Basestation packages built by Clearpath Robotics" -component="basestation" -distribution="trusty" trusty-basestation
sudo aptly repo create -comment="The PR2 ROS Packages" -component="main" -distribution="trusty" trusty-pr2-ros
sudo aptly repo create -comment="The PR2 Deb Packages" -component="pr2" -distribution="trusty" trusty-pr2-debs
sudo aptly repo create -comment="The PR2 Ubuntu Desktop packages" -component="main" -distribution="trusty" trusty-pr2-desktop

# importing the mirrors into the repos
sudo aptly repo --with-deps=true -architectures="amd64" import trusty-base trusty-base ubuntu-minimal
sudo aptly repo --with-deps=true -architectures="amd64" import trusty-pr2-debs trusty-pr2-debs pr2-environment pr2-network pr2-core
sudo aptly repo --with-deps=true -architectures="amd64" import trusty-desktop trusty-desktop ubuntu-desktop
sudo aptly repo --with-deps=true -architectures="amd64" import trusty-pr2-ros trusty-pr2-ros ros-indigo-pr2-simulator ros-indigo-pr2-bringup  ros-indigo-pr2-robot ros-indigo-pr2-navigation ros-indigo-pr2-ethercat-drivers ros-indigo-pr2-power-drivers ros-indigo-wge100-driver ros-indigo-wifi-ddwrt ros-indigo-hokuyo-node ros-indigo-prosilica-camera ros-indigo-camera1394 ros-indigo-linux-networking ros-indigo-pr2-navigation-apps ros-indigo-sicktoolbox ros-indigo-sicktoolbox-wrapper  ros-indigo-joystick-drivers  ros-indigo-microstrain-3dmgx2-imu ros-indigo-audio-common
sudo aptly repo --with-deps=true -architectures="amd64" import trusty-basestation trusty-basestation pr2-basestation ubuntu-desktop 
sudo aptly repo --with-deps=true -architectures="amd64" import trusty-pr2-desktop trusty-pr2-desktop ros-indigo-desktop-full ros-indigo-pr2-ethercat-drivers ros-indigo-rqt-pr2-dashboard ros-indigo-pr2-simulator ros-indigo-pr2-power-drivers  ros-indigo-pr2-navigation ros-indigo-control-msgs ros-indigo-geometry-experimental   ros-indigo-joystick-drivers ros-indigo-mobile  ros-indigo-moveit-full-pr2 ros-indigo-perception ros-indigo-perception-pcl ros-indigo-pr2-apps ros-indigo-pr2-calibration ros-indigo-pr2-common ros-indigo-pr2-common-actions ros-indigo-pr2-controllers  ros-indigo-pr2-kinematics ros-indigo-pr2-mechanism  ros-indigo-ros-realtime ros-indigo-sql-database ros-indigo-warehouse-ros


