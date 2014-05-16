### ZIP all the memory report files
if [ -e about-memory.zip ];then
   echo "Removing Old Memory Report Files"
   rm -f about-memory.zip
fi

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

### check if we need to kill to get minidump
if [ -z "$GET_MINIDUMP" ] || [ "$GET_MINIDUMP" == "true" ]; then
    ### kill b2g to get its crash report
    echo "Killing B2G For Getting DMP Files"
    B2G_PID=$(adb shell b2g-ps | grep b2g -m 1 | awk -F" " '{print $3}')
    echo "B2G pid: $B2G_PID"
    adb shell kill -11 $B2G_PID

    sleep 10
    adb pull /data/b2g/mozilla/Crash\ Reports/pending/ . || echo 0
    
    unzip $WORKSPACE/symbols.zip -d symbols/
    ### get minidump from minidump_stackwalk
    cp /mnt/mtbf_shared/memory_tools/minidump_stackwalk .
    if [ -e *.dmp ];then
       echo "Getting Minidump"
       DMP=$(ls *.dmp -1)
       for file in $DMP
          do
             ./minidump_stackwalk $file symbols/ > result_$file.txt
          done
    fi
    rm -rf symbols/
fi
exit 0
