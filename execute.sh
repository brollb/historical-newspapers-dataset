CMD=$1
LENGTH=$(jq '.ocr | length' ocr.json)
MAX_INDEX=$(echo "$LENGTH-1" | bc)
echo "MAX_INDEX $MAX_INDEX"
INDICES=$(seq 0 1 $MAX_INDEX)
rm download-has-failed.txt 2> /dev/null # This marks if a download has failed

echo $INDICES | tr " " "\n" | parallel -j5 bash $CMD.sh {}

# Uncomment to download serially
#for index in $INDICES; do
    #bash download-if-needed.sh $index
#done
