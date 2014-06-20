#!/bin/bash -x

### Enter virtual environment
source .env/bin/activate

cd mtbf_driver

### may need to make environmental variables for testvars file
cp $TESTVAR testvars.json

### may need to make environmental variables for options
if [[ -z "$PORT" ]]; then
    FILTER=$(MOZ_IGNORE_NUWA_PROCESS=true MTBF_TIME=$MTBF_TIME MTBF_CONF=$CONF_LOCATION mtbf --address=localhost:2828 --testvars=testvars.json $TEST_TORUN)
else
    FILTER=$(MOZ_IGNORE_NUWA_PROCESS=true MTBF_TIME=$MTBF_TIME MTBF_CONF=$CONF_LOCATION mtbf --address=localhost:$PORT --testvars=testvars.json $TEST_TORUN)
fi

echo "EXIT_STAT=$?" > temp_env

