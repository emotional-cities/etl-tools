#!/bin/bash
#Note: gdal > 3.7

walk_dir () {    
    shopt -s nullglob dotglob

    for pathname in "$1"/*; do
        if [ -d "$pathname" ]; then
            walk_dir "$pathname"
        else
            case "$pathname" in
                *.shp)
                    #echo $pathname
                    LAYER=$($GDAL_PATH/ogrinfo -json "$pathname" | jq '.layers[0].name')
                    echo "Converting $LAYER to GeoJSON"
                    OUT=$(echo $LAYER | tr -d '"')
                    OUT_L=$(echo "$OUT" | tr '[:upper:]' '[:lower:]')
                    # echo $OUT_L
                    $GDAL_PATH/ogr2ogr $OUTPUT_DIR/$OUT_L.geojson "$pathname" -f GeoJSON -explodecollections -t_srs EPSG:4326
                    #echo "Converting $LAYER to GeoPackage"
                    $GDAL_PATH/ogr2ogr $OUTPUT_DIR/$OUT_L.gpkg "$pathname" -f GPKG -explodecollections -t_srs EPSG:4326
            esac
        fi
    done
}

GDAL_PATH=/home/joana/apps/bin/
DOWNLOADING_DIR=/home/joana/projects/EC/msu
OUTPUT_DIR=/home/joana/projects/EC/msu/output

walk_dir "$DOWNLOADING_DIR"