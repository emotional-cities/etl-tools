#!/bin/bash
#Note: gdal > 3.8.4
# requires aws-cli and docker installed!

my_array=()
while IFS= read -r line; do
    my_array+=( "$line" )
done < <( /bin/aws s3 ls emotional-cities/geojson/ | sed -nr 's/.* ([^ ]*.)/\1/p' )

# my_array_length=${#my_array[@]}
# echo ${my_array_length}

for element in "${my_array[@]}"
do
    echo "converting ${element}..."
    filename=$(basename -- ${element} .geojson)
    #echo ${filename}
    docker run -v "${PWD}/data:/mnt" ghcr.io/osgeo/gdal:ubuntu-full-3.8.4  \
        ogr2ogr --config AWS_REGION "eu-central-1" --config AWS_ACCESS_KEY_ID $AWSAccessKeyId \
        --config AWS_SECRET_ACCESS_KEY $AWSSecretKey -f parquet /vsis3/emotional-cities/geoparquet/${filename}.parquet \
        /vsis3/emotional-cities/geojson/${element}
done

echo "done!"

#docker run -v "${PWD}/data:/mnt" ghcr.io/osgeo/gdal:ubuntu-full-3.8.4 ogrinfo --version
#docker run -v "${PWD}/data:/mnt" ghcr.io/osgeo/gdal:ubuntu-full-3.8.4  ogr2ogr -f parquet /mnt/obs.parquet /mnt/obs.geojson
#docker run -v "${PWD}/data:/mnt" ghcr.io/osgeo/gdal:ubuntu-full-3.8.4  python3 /mnt/validate_geoparquet.py /mnt/obs.parquet
#./gpq validate data/obs.parquet
#docker run -v "${PWD}/data:/mnt" ghcr.io/osgeo/gdal:ubuntu-full-3.8.4  ./mnt/gpq validate /mnt/obs.parquet
#ogrinfo --config AWS_REGION "eu-central-1" --config AWS_ACCESS_KEY_ID $AWSAccessKeyId --config AWS_SECRET_ACCESS_KEY $AWSSecretKey /vsis3/emotional-cities/geojson/a00000009.geojson
