#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_directory> <output_directory>"
    exit 1
fi

input_dir="$1"
output_dir="$2"

mkdir -p "$output_dir"
files_in_input_dir=$(find "$input_dir" -maxdepth 1 -type f)
cp -n $files_in_input_dir "$output_dir"
dirs_in_input_dir=$(find "$input_dir" -maxdepth 1 -type d)
files_in_subdirs=$(find "$input_dir" -mindepth 1 -type f)

for file in $files_in_subdirs; do
    filename=$(basename "$file")
    if [ -e "$output_dir/$filename" ]; then
        filename="${filename}_$(date +%s)"
    fi
    cp "$file" "$output_dir/$filename"
done

echo "Copying completed."
