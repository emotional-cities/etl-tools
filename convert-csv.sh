#!/bin/bash


walk_dir () {    
    shopt -s nullglob dotglob

    for pathname in "$1"/*; do
        if [ -d "$pathname" ]; then
            walk_dir "$pathname"
        else
            case "$pathname" in
                *.csv)
                    LAYER=$(ogrinfo -json "$pathname" | jq '.layers[0].name')
                    echo "converting $LAYER to GeoJSON"
                    OUT=$(echo $LAYER | tr -d '"')
                    OUT_L=$(echo "$OUT" | tr '[:upper:]' '[:lower:]')
                    cp template.vrt $OUT.vrt
                    sed -i "s/DATASET/$OUT/g" $OUT.vrt
                    sed -i "s/FILENAME/$OUT.csv/g" $OUT.vrt
                    ogr2ogr -f GeoJSON $OUTPUT_DIR/$OUT.geojson $OUT.vrt
             esac
        fi
    done
}

DOWNLOADING_DIR=/home/joana/git/etl-tools/data/csv
OUTPUT_DIR=/home/joana/git/etl-tools/data/gpkg

walk_dir "$DOWNLOADING_DIR"

