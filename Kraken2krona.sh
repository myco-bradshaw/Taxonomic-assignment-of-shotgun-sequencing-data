#!/bin/bash

#Create a varible that matches the directory name, makes it easy to name output files
result=${PWD##*/}
printf '%s\n' "${PWD##*/}"


#Make a Krona Chart for fungal only seqs, change location to the kreport you want to generate a report for
python3 /home/abradshaw/scripts_alex/working/KrakenTools/kreport2krona.py \
--no-intermediate-ranks \
-r ./Kraken_Fungi/$result.Fungi.kreport \
-o ./Kraken_Fungi/$result.Fungi.only.kreport.krona


#use Krona tools to generate the interactive html krona chart
/home/abradshaw/miniconda3/bin/ktImportText ./Kraken_Fungi/$result.Fungi.only.kreport.krona -o ./Kraken_Fungi/$result.Fungi.only.kreport.krona.html



exit 0