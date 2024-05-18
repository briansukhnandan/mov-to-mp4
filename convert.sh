#!/bin/sh

SHOULD_USE_FAST_PROCESSING="false"

#####################
# Process arguments #
#####################
while getopts p:f:g:o: flag
do
  case "${flag}" in
    # Remove trailing / from dir path and mod files path.
    p) path=$(echo ${OPTARG} | sed 's:/*$::');;
    f) SHOULD_USE_FAST_PROCESSING = "true"
  esac
done

if [ -d $path ]; then
  fileIdx=0
  outdir="$path/output/"
  mkdir p $outdir

  for file in "$path"/*; do
    outputFileName="output_$fileIdx.mp4"
    echo "Processing file $file. Saving to $outputFileName"

    if [ $SHOULD_USE_FAST_PROCESSING == "true" ]; then
      echo "Processing without encoding (fast)..."
      ffmpeg -i $file -qscale 0 $outdir/$outputFileName
    else
      echo "Processing using encoding (best quality)..."
      ffmpeg -i $file -q:v 0 $outdir/$outputFileName
    fi

    (( fileIdx++ ))
  done
fi
