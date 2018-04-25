# Detect if the download failed
mkdir data/

INDEX=$1
URL=$(jq ".ocr[$INDEX].url" ocr.json | sed 's/"//g')
FILE=data/$(jq ".ocr[$INDEX].name" ocr.json | sed 's/"//g')
HASH=$(jq ".ocr[$INDEX].sha1" ocr.json | sed 's/"//g')
echo $FILE

# Check if the file exists
if [ -f $FILE ]; then
    # Check if the hash is correct
    ACTUAL_HASH=$(sha1sum $FILE | cut -d" " -f1)
    if [ "$ACTUAL_HASH" != "$HASH" ]; then
        echo "removing $FILE"
        rm $FILE
    fi
else
    echo "File does not exist"
fi
