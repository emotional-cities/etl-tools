#!/bin/bash

walk_dir () {    
    shopt -s nullglob dotglob

    for pathname in "$1"/*; do
        if [ -d "$pathname" ]; then
            walk_dir "$pathname"
        else
            case "$pathname" in
                *.geojson)
                    echo $pathname
                    ogrinfo "$pathname"
                    LAYER=$(ogrinfo -json "$pathname" | jq '.layers[0].name')
                    #echo "Converting $LAYER to GeoPackage"
                    OUT=$(echo $LAYER | tr -d '"')
                    OUT_L=$(echo "$OUT" | tr '[:upper:]' '[:lower:]')
                    ogr2ogr $OUTPUT_DIR/$OUT_L.gpkg "$pathname" -nln "$OUT" -f GPKG  -a_srs 'EPSG:4326'
             esac
        fi
    done
}

DOWNLOADING_DIR=/home/joana/git/etl-tools/data/geojson
OUTPUT_DIR=/home/joana/git/etl-tools/data/gpkg

walk_dir "$DOWNLOADING_DIR"

