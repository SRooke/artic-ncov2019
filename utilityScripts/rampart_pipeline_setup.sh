#!/usr/bin/env bash/bin/bash
echo 'Please refer to the template directory structure the /data/COVID19/ directory for the standardised layout that this script requires.'
echo 'Now, please enter the library name for the run (YYYY-MM-DD_Run##):'
read LIB

DIRECTORY="/data/COVID19/$LIB"
mkdir -p $DIRECTORY
ANALYSIS="$DIRECTORY/analysis"
echo $ANALYSIS
mkdir $ANALYSIS

FASTQDIR=`find $DIRECTORY -maxdepth 1 -type d -regextype egrep -regex ".*/[0-9]{8}_[0-9]{4}_[A-Z]*[0-9]*_.*" -exec stat -t {} \; | sort -r -n | head -1 | awk '{print $1}'`

cp  /data/COVID19/RunTemplate/YYYY-MM-DD-RunID/analysis/run_configuration.json $DIRECTORY/analysis/
sed -e "s%TITLE%$LIB%g" -i $DIRECTORY/analysis/run_configuration.json
sed -e "s%FASTQDIRECTORY%$FASTQDIR/fastq_pass%g" -i $DIRECTORY/analysis/run_configuration.json

cp $DIRECTORY/$LIB.csv $ANALYSIS/barcodes.csv
sed -i 's/NB/barcode/g' $ANALYSIS/barcodes.csv

echo 'Completed preparation for RAMPART and post-processing pipelines. Now RAMPART can be run.'