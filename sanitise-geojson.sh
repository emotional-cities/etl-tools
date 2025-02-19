#!/bin/bash


directory=/home/joana/projects/EC/nrg/geojson  # Use first argument as directory, default to current directory

# Loop over all files in the directory
for file in "$directory"/*; do
    if [[ -f "$file" ]]; then  # Ensure it's a file
        dir=$(dirname -- "$file")
        base=$(basename -- "$file")
        name="${base%.*}"
        ext="${base##*.}"
        
        if [[ "$name" == "$ext" ]]; then
            newname=$(echo "$name" | tr '[:upper:]' '[:lower:]' | tr '.' '_')
        else
            newname=$(echo "$name" | tr '[:upper:]' '[:lower:]' | tr '.' '_').$ext
        fi
        
        if [[ "$base" != "$newname" ]]; then
            mv "$file" "$dir/$newname"
            echo "Renamed: $base -> $newname"
        fi
    fi
done
