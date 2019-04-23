#!/usr/bin/env bash

#docker build -t land_cover_classification -f Dockerfile . --build-arg manifest="$(cat UP42Manifest.json)"

tmp_dir=/tmp/e2e_landcover
input_dir=$tmp_dir/input
output_dir=$tmp_dir/output
rm -rf $output_dir
mkdir -p $output_dir

#gsutil cp gs://blocks-e2e-testing/b2257c41-08da-46e0-8aac-17534a214482.tif $tmp_dir/input
#cp $(pwd)/tests/test_data/data.json $tmp_dir/input

docker run -v $tmp_dir:/tmp -it land_cover_classification