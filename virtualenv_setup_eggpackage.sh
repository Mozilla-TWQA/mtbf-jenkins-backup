#!/bin/bash -x

### Create virtual environments
rm -rf .env
virtualenv .env
source .env/bin/activate

### Setup gaiatest
python setup.py develop

### Get memory tools
cp -rf /mnt/mtbf_shared/memory_tools/tools/ .
