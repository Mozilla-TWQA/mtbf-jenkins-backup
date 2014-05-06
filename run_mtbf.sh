#!/bin/bash -x

### Enter virtual environment
cd $WORKSPACE/tests/python/gaia-ui-tests/
source .env/bin/activate

### Run gaiatest
cd $WORKSPACE/tests/python/gaia-ui-tests/gaiatest/
###    may need to make environmental variables for testvars file
cp $TESTVAR testvars.json
###    may need to make environmental variables for options
MOZ_IGNORE_NUWA_PROCESS=true MTBF_TIME=$MTBF_TIME python mtbf.py --address=localhost:2828 --testvars=testvars.json $TEST_TORUN
