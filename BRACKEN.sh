#!/bin/bash

#Create a varible that matches the directory name, makes it easy to name output files
result=${PWD##*/}
printf '%s\n' "${PWD##*/}"

#Use bracken to estimate abundances for all seqs 
#This step is noted to be the correct step post kraken analysis by creators
#bracken -d /path/to/kraken/database \
#-i /path/to/kreport
#-o output/name.bracken.species.txt

bracken -d /home/bdentinger/whisky/analyses_Mar2020/bigDB/ \
-i ./Kraken_bigDB/All_seqs/$result.bigDB.kreport \
-o ./Kraken_bigDB/All_seqs/$result.bigDB.kreport.bracken.species.txt


exit 0
