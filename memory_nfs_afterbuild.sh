#!/bin/bash -x
hostname
pwd

### ZIP all the memory report files
if [ -e about-memory.zip ];then
   echo "Removing Old Memory Report Files"
   rm -f about-memory.zip
fi

cd mtbf_driver
echo "Creating all-about-memory Folder"
mkdir -p all-about-memory
if [ -e about-memory-0 ];then
   echo "Moving All The Memory Status Files"
   mv about-memory-* all-about-memory
fi

echo "Ziping All The Memory Status File And Removing Folders"
zip -r -9 -u about-memory.zip all-about-memory
rm -rf about-memory-*
rm -rf all-about-memory

pwd
ls

echo "Trying to search for all information needed for zip"
if [ -e b2ginfo0 ];then
   rm -f result_b2ginfo.zip
   echo "zipping b2ginfo"
   zip result_b2ginfo.zip b2ginfo*
   rm -f b2ginfo*
fi

if [ -e b2gprocrank0 ];then
   rm -f result_b2gprocrank.zip
   echo "zipping b2gprocrank"
   zip result_b2gprocrank.zip b2gprocrank*
   rm -f b2gprocrank*
fi

if [ -e b2gps0 ];then
   rm -f result_b2gps.zip
   echo "zipping b2gps"
   zip result_b2gps.zip b2gps*
   rm -f b2gps*
fi

if [ -e bugreport0 ];then
   rm -f result_bugreport.zip
   echo "zipping bugreport"
   zip result_bugreport.zip bugreport*
   rm -f bugreport*
fi

if [ -e dmesg0 ];then
   rm -f result_dmesg.zip
   echo "zipping dmesg"
   zip result_dmesg.zip dmesg*
   rm -f dmesg*
fi

if [ -e getevent0 ];then
   rm -f result_getevent.zip
   echo "zipping getevent"
   zip result_getevent.zip getevent*
   rm -f getevent*
fi


if [ -e logcat0 ];then
   rm -f result_logcat.zip
   echo "zipping logcat"
   zip result_logcat.zip logcat*
   rm -f logcat*
fi

### check if we need to kill to get minidump
if [ -z "$GET_MINIDUMP" ] || [ $GET_MINIDUMP ];then
    rm *.dmp
    ### kill b2g to get its crash report
    echo "Killing B2G For Getting DMP Files"
    B2G_PID=$(adb shell b2g-ps | grep b2g -m 1 | awk -F" " '{print $3}')
    echo "B2G pid: $B2G_PID"
    adb shell kill -11 $B2G_PID

    sleep 30
    adb pull /data/b2g/mozilla/Crash\ Reports/pending/ . || echo 0
    
    unzip $WORKSPACE/symbols.zip -d symbols/
    ### get minidump from minidump_stackwalk
    cp /mnt/mtbf_shared/memory_tools/minidump_stackwalk .

    for dmpfile in *.dmp
    do
        adb shell rm /data/b2g/mozilla/Crash\ Reports/pending/$dmpfile
        ./minidump_stackwalk $dmpfile symbols/ > minidmp_result_$dmpfile.txt
    done

rm -rf symbols/
fi

exit $EXIT_STAT

