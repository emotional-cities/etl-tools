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
                    #printf '%s\n' "$pathname"
                    #ogrinfo "$pathname"
                    LAYER=$($GDAL_PATH/ogrinfo -json "$pathname" | jq '.layers[0].name')
                    #CRS=$("$GDAL_PATH"/ogrinfo -json "$pathname" | jq '.layers[0].geometryFields[0].coordinateSystem.projjson.id.code')
                    echo "Converting $LAYER to GeoJSON"
                    OUT=$(echo $LAYER | tr -d '"')
                    #echo $OUT
                    $GDAL_PATH/ogr2ogr $OUTPUT_DIR/$OUT.geojson "$pathname" -f GeoJSON -t_srs EPSG:4326
                    echo "Converting $LAYER to GeoPackage"
                    $GDAL_PATH/ogr2ogr $OUTPUT_DIR/$OUT.gpkg "$pathname" -f GPKG -t_srs EPSG:4326
                    exit
            esac
        fi
    done
}

GDAL_PATH=/home/joana/apps/bin/
DOWNLOADING_DIR=/home/joana/projects/EC/msu
OUTPUT_DIR=/home/joana/projects/EC/msu/output

walk_dir "$DOWNLOADING_DIR"