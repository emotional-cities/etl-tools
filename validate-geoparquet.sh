#!/bin/bash


my_array=()
while IFS= read -r line; do
    my_array+=( "$line" )
done < <( /bin/aws s3 ls emotional-cities/geoparquet/ | sed -nr 's/.* ([^ ]*.)/\1/p' )

for element in "${my_array[@]}"
do
    echo "validating ${element}..."
    # ./gpq validate data/obs.parquet
done

echo "done!"