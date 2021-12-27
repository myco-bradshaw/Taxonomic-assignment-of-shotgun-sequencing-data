#!/bin/bash
#-i/--input MYFILE.BRACKEN..........Bracken output file
#-o/--output MYFILE.BRACKEN_NEW.....Bracken-style output file with filtered taxids
#--include TID TID2.................taxonomy IDs to include in output file [space-delimited]
#--exclude TID TID2.................taxonomy IDs to exclude in output file [space-delimited]
python3 /home/abradshaw/scripts_alex/working/KrakenTools/filter_bracken.out.py \
-i location/of/bracken.species.txt \
-o output.name.taxon.txt \
--include NCIB#/of/taxon/of/intrest

exit 0