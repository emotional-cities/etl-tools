# ETL Tools

<img src="https://raw.githubusercontent.com/doublebyte1/yellow-bricks/master/dist/assets/img/portfolio/ecities.svg" width="200">

Helper tools to insert data into the sdi. _You will need the [bash](https://www.gnu.org/software/bash/) shell to run these scripts!_

## Quick Setup

Convert a myriad of formats on different folders to the eMOTIONAL Cities recommended formats: `GeoJSON`, `GeoPackage` and `GeoParquet`.

Befor running the scripts, make sure you give them run permissions:

```
chmod +x convert-shp.sh
```

```
./convert-shp.sh
```

## Script List

* [convert-csv.sh](./convert-csv.sh): bulk conversion of csv files on a local folder, to geojson, using `template.vrt` (check this file for custom options)
* [convert-geojson.sh](./convert-geojson.sh): bulk conversion of geojson files on a local folder to geopackage
* [convert-geoparquet.sh](./convert-geoparquet.sh): bulk conversion of geojson files on a S3 bucket to geoparquet, placing them on another s3 bucket
* [convert-gpkg.sh](./convert-gpkg.sh): bulk conversion of csv files on a local folder to geopackage
* [convert-shp.sh](./convert-shp.sh): bulk conversion of shapefiles files on a local folder to geopackage
* [geojson2gpkg.sh](./geojson2gpkg.sh): variation of `convert-geojson.sh`
* [convert-pgdump.sh](./convert-geojson.sh): bulk conversion of geojson files in a single postgis sql create/insert script
  
## Requirements

* [GDAL](https://gdal.org/) >= 3.7
* [jq](https://stedolan.github.io/jq/)
* [aws-cli](https://aws.amazon.com/cli/)
* [docker](https://docs.docker.com/get-docker/)
  
## License

This project is released under an [MIT License](./LICENSE)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)