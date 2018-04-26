INDEX=$1
URL=$(jq ".ocr[$INDEX].url" ocr.json | sed 's/"//g')
FILE=data/$(jq ".ocr[$INDEX].name" ocr.json | sed 's/"//g')
HASH=$(jq ".ocr[$INDEX].sha1" ocr.json | sed 's/"//g')
echo $FILE

NEEDS_DOWNLOAD=0
# Check if the file exists
if [ -f $FILE ]; then
    echo "File exists"
else
    echo "File does not exist"
    NEEDS_DOWNLOAD=1
fi

# If needs download, download it
if [ $NEEDS_DOWNLOAD -eq 1 ]; then
    echo "downloading!"
    wget $URL -O $FILE || touch download-has-failed.txt
else
    echo "skipping $FILE. Already downloaded."
fi
