#!/bin/bash -x

### Create virtual environments
cd $WORKSPACE/tests/python/gaia-ui-tests/
rm -rf .env
virtualenv .env
source .env/bin/activate

### Setup gaiatest
python setup.py develop
#pip install -Ur $WORKSPACE/tests/python/gaia-ui-tests/gaiatest/tests/requirements.txt

### Get memory tools
cd $WORKSPACE/tests/python/gaia-ui-tests/gaiatest/
cp -rf /mnt/mtbf_shared/memory_tools/tools/ .

### Get mtbf driver
cp -rf /mnt/mtbf_shared/MTBF-Driver/mtbf-driver/* .

