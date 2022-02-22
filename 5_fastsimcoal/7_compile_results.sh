#!/bin/bash

cd fastsimcoal

for region in CA OR WA MT
do

	cd $region

	echo "SEARCH_ID" $(head -n 1 ML_SEARCH_1/*/*.best*) > ${region}_ML.txt

	for folder in ML_SEARCH_* ; do echo $folder $(find $folder -name '*.bestlhoods' -exec tail -n 1 {} \;); done | sort -g -k7,7 >> ${region}_ML.txt

	cd ..

done