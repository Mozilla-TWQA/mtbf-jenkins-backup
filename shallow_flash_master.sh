#!/bin/bash -x

rm -rf b2g-distro
cp /var/lib/jenkins/resource/B2G-flash-tool/shallow_flash.sh .

# You need to get the gaia.zip and b2g.tar.gz from other project/job
pwd
./shallow_flash.sh --gaia=gaia.zip --gecko=b2g.tar.gz -y
rm -rf gaia.zip b2g.tar.gz
