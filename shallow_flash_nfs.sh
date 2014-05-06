#!/bin/bash -x

### default to flash the phone
if [ -z "$FLASH_PHONE" ] || [ "$FLASH_PHONE" == "true" ]; then
    ### get shallow flash script and all related build files
    cp /mnt/mtbf_shared/shallow_flash.sh .
    cp /mnt/mtbf_shared/buri_v1.4/* .

    ### shallow flash the build
    pwd
    ./shallow_flash.sh --gaia=gaia.zip --gecko=b2g.tar.gz -y
    rm -rf gaia.zip b2g.tar.gz
fi
