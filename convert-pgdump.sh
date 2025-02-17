#!/bin/bash
#Note: gdal > 3.7

walk_dir () {    
    shopt -s nullglob dotglob
    mkdir $OUTPUT_DIR/temp

    for pathname in "$1"/*; do
        if [ -d "$pathname" ]; then
            walk_dir "$pathname"
        else
            case "$pathname" in
                *.geojson)
                    #echo $pathname
                    LAYER=$($GDALINFO_PATH -json "$pathname" | jq '.layers[0].name')
                    echo "Converting $LAYER to PGdump"
                    OUT=$(echo $LAYER | tr -d '"')
                    OUT_L=$(echo "$OUT" | tr '[:upper:]' '[:lower:]')
                    # Converting $LAYER to sql script
                    $GDAL_PATH $OUTPUT_DIR/temp/$OUT_L.sql "$pathname" -f PGDump -a_srs EPSG:4326 -lco LAUNDER=YES -lco GEOMETRY_NAME=geometry 
            esac
        fi
    done

    rm $OUTPUT_DIR/all.sql
    # merging into single script
    cat $OUTPUT_DIR/temp/*.sql >> $OUTPUT_DIR/all.sql
    # removing temp files
    rm -rf $OUTPUT_DIR/temp/
}

GDAL_PATH=$(which ogr2ogr)
GDALINFO_PATH=$(which ogrinfo)
DOWNLOADING_DIR=./geojson
OUTPUT_DIR=./sql

walk_dir "$DOWNLOADING_DIR"