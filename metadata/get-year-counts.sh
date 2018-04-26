# Get the number of documents per year
FILENAME=$1
INPUT_FILE=raw/$1
OUTPUT_FILE=year-counts/$1
echo "counting documents per year for $1"
cat $INPUT_FILE | tr -s " " | cut -d" " -f6 | cut -d"/" -f2 | sort | uniq -c > $OUTPUT_FILE
