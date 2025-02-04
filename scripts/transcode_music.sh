#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi


find "$1" -type f \( -iname "*.mp3" -o -iname "*.wav" -o -iname "*.flac" -o -iname "*.aac" -o -iname "*.m4a" \) | while read -r file; do

  ext="${file##*.}"
  if [ "$ext" != "opus" ]; then
    newfile="${file%.*}.opus"
    touch "$newfile"
    echo "Transcoding $file to $newfile"

    if [ "$(ffmpeg -nostdin -i "$file" -c:a libopus -b:a 160k -vbr 1 -compression_level 10 -y "$newfile")" -eq 0 ]; then
      echo "Transcoding successful for $file"
      rm "$file"
    else
      echo "Transcoding failed for $file"
    fi
  fi
done
