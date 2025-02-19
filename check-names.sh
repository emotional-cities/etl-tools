#!/bin/bash
#Note: gdal > 3.8.4
# requires aws-cli and docker installed!

my_array=()
while IFS= read -r line; do
    my_array+=( "$line" )
done < <(aws s3 ls emotional-cities/geojson/ | grep '.geojson' | sed -nr 's/.* ([^ ]*.)/\1/p')

# my_array_length=${#my_array[@]}
# echo ${my_array_length}

for element in "${my_array[@]}"
do
    #echo "Checking ${element}..."
    filename=$(basename -- ${element} .geojson)
    if [[ $filename =~ [A-Z ]]
    then
        echo ${filename}
    fi
done
echo "done!"