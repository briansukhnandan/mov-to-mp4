#!/bin/sh

#####################
# Process arguments #
#####################
while getopts p: flag
do
  case "${flag}" in
    # Remove trailing / from dir path and mod files path.
    p) path=$(echo ${OPTARG} | sed 's:/*$::');;
  esac
done

if [ -d $path ]; then
  fileIdx=0
  outdir="$path/output/"
  mkdir p $outdir

  for file in "$path"/*; do
    if [[ -f $file ]]; then
      outputFileName="output_$fileIdx.mp4"
      echo "Processing using encoding (best quality)..."
      ffmpeg -i $file -q:v 0 $outdir/$outputFileName
      (( fileIdx++ ))
    fi
  done
fi
