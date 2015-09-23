#!/bin/bash

cd /var/repos/pr2packages/ubuntu/conf
cat deplist.pkgs >> trustydeps.packages
awk '!seen[$0]++' trustydeps.packages > trustydepsnew.packages
mv trustydepsnew.packages trustydeps.packages
cd ../
reprepro -Vb . --noskipold update trusty
