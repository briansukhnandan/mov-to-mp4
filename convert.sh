#!/bin/sh

while getopts :p:m: flag
do
  case "${flag}" in
    # Remove trailing / from dir path.
    p) path=$(echo ${OPTARG} | sed 's:/*$::');;
    # Either "fast", or anything else prioritizes quality.
    m) mode=$(echo ${OPTARG});;
  esac
done

if [ -d $path ]; then
  fileIdx=0
  outdir="$path/output/"
  mkdir -p $outdir

  for file in "$path"/*; do
    if [[ -f $file ]]; then
      outputFileName="output_$fileIdx.mp4"
      if [ $mode == "fast" ]; then
        echo "Processing without encoding (prioritizes speed)..."
        ffmpeg -i $file -qscale 0 $outdir/$outputFileName
        (( fileIdx++ ))
      else
        echo "Processing using encoding (best quality)..."
        ffmpeg -i $file -q:v 0 $outdir/$outputFileName
        (( fileIdx++ ))
      fi
    fi
  done
fi
