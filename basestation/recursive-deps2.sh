#!/bin/bash

cd /var/repos/pr2-dev-internal/ubuntu/conf
cat deplist.pkgs >> trustydeps.packages
awk '!seen[$0]++' trustydeps.packages > trustydepsnew.packages
mv trustydepsnew.packages trustydeps.packages
cp trustydeps.packages trustydepsi386.packages
sed -e 's/^[^ ]*\>/&:i386/'
cd ../
reprepro -Vb . --noskipold update trusty
