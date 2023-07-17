#!/bin/bash
#Note: gdal > 3.7

walk_dir () {    
    shopt -s nullglob dotglob

    for pathname in "$1"/*; do
        if [ -d "$pathname" ]; then
            walk_dir "$pathname"
        else
            case "$pathname" in
                *.csv)
                    echo $pathname
                    #$GDAL_PATH/ogrinfo "$pathname"
                    LAYER=$($GDAL_PATH/ogrinfo -json "$pathname" | jq '.layers[0].name')
                    #echo "Converting $LAYER to GeoPackage"
                    OUT=$(echo $LAYER | tr -d '"')
                    OUT_L=$(echo "$OUT" | tr '[:upper:]' '[:lower:]')
                    $GDAL_PATH/ogr2ogr $OUTPUT_DIR/$OUT_L.gpkg "$pathname" -f GPKG -oo X_POSSIBLE_NAMES="GPS (Long.) [deg]" -oo Y_POSSIBLE_NAMES="GPS (Lat.) [deg]" -oo Y_POSSIBLE_NAMES="GPS (Alt.) [m]" -a_srs 'EPSG:4326'
             esac
        fi
    done
}

GDAL_PATH=/home/joana/apps/bin/
DOWNLOADING_DIR=/home/joana/projects/EC/fmul/Video\ data/Videos/
OUTPUT_DIR=/home/joana/projects/EC/fmul/output/

walk_dir "$DOWNLOADING_DIR"

