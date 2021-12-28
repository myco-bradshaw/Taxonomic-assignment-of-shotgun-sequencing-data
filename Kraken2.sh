#!/bin/bash

#Create a varible that matches the directory name, makes it easy to name output files
result=${PWD##*/}
printf '%s\n' "${PWD##*/}"

#make analysis directories for each database type
#checks to see if a directory exists, makes it if it does not
[ -d Kraken_Bacterial ] || mkdir Kraken_Bacterial
[ -d Kraken_Fungi ] || mkdir Kraken_Fungi
#[ -d Kraken_UNITE ] || mkdir Kraken_UNITE
[ -d Kraken_bigDB ] || mkdir Kraken_bigDB



#For Kraken_bigDB, database includes all NCBI, JGI fungal Genomes, as well as KEW plant sequences
#for genome assemlies
#Combination database for all of NCBI and all fungal genomes from JGI
kraken2 --db /home/bdentinger/whisky/analyses_Mar2020/bigDB/ \
--threads 36 --gzip-compressed --use-names \
--memory-mapping \
--report ./Kraken_bigDB/$result.bigDB.kreport \
--output ./Kraken_bigDB/$result.bigDB.kreport.kraken \
./*contigs.fasta.gz

#for paired end reads
#Combination database for all of NCBI and all fungal genomes from JGI
#kraken2 --db /home/bdentinger/whisky/analyses_Mar2020/bigDB/ \
#--threads 36 --gzip-compressed --use-names \
#--memory-mapping \
#--report ./Kraken_bigDB/$result.bigDB.kreport \
#--output ./Kraken_bigDB/$result.bigDB.kreport.kraken \
#--paired ./*R1_001.fastq.gz ./*R2_001.fastq.gz

/


#Use to classify Bacterial Sequences from NCBI standard database
#for genome assemlies
kraken2 --db /home/bdentinger/whisky/analyses_Mar2020/standard/ \
--threads 36 --gzip-compressed --use-names \
--memory-mapping \
--report ./Kraken_Bacterial/$result.bacterial.kreport \
--output ./Kraken_Bacterial/$result.bacterial.kraken \
./*contigs.fasta.gz

#for paired end reads
#Combination database for all of NCBI and all fungal genomes from JGI
#kraken2 --db /home/bdentinger/whisky/analyses_Mar2020/standard/ \
#--threads 36 --gzip-compressed --use-names \
#--memory-mapping \
#--report ./Kraken_Bacterial/$result.bacterial.kreport \
#--output ./Kraken_Bacterial/$result.bacterial.kraken \
#--paired ./*R1_001.fastq.gz ./*R2_001.fastq.gz






#To classify Fungi
#for genome assemlies
kraken2 --db /home/bdentinger/whisky/analyses_Mar2020/fungi27Mar20/ \
--threads 36 --gzip-compressed --use-names \
--memory-mapping \
--report ./Kraken_Bacterial/$result.Fungi.kreport \
--output ./Kraken_Fungi/$result.Fungi.kraken \
./*contigs.fasta.gz

#for paired end reads
#Combination database for all of NCBI and all fungal genomes from JGI
#kraken2 --db /home/bdentinger/whisky/analyses_Mar2020/fungi27Mar20/ \
#--threads 36 --gzip-compressed --use-names \
#--memory-mapping \
#--report ./Kraken_Bacterial/$result.Fungi.kreport \
#--output ./Kraken_Bacterial/$result.Fungi.kraken \
#--paired ./*R1_001.fastq.gz ./*R2_001.fastq.gz





#using UNITE database
##This one did horribly at classification, left commented out in case it is useful in the future
#Classify with whole EUK UNITE database
#kraken2 --db /home/bdentinger/whisky/analyses_Mar2020/unite_all_euk/ --threads 36 --gzip-compressed --use-names --report \
#./Kraken_UNITE/$result.UNITE.kreport --report-zero-counts --output ./Kraken_UNITE/$result.UNITE.kreport.kraken \
#--paired ./split_input/*.InIn_1.fastq.gz ./split_input/*.InIn_2.fastq.gz

#make krona chart for UNITE database
#cut -f3,5 ./Kraken_UNITE/$result.UNITE.kreport > ./Kraken_UNITE/$result.UNITE.krona

#/home/bdentinger/KronaTools-2.7/scripts/ImportTaxonomy.pl ./Kraken_UNITE/$result.UNITE.krona -o ./Kraken_UNITE/$result.UNITE.krona.html

#make krona chart that includes no-hit sequences
#cut -f3,5 ./Kraken_UNITE/$result.UNITE.kreport > ./Kraken_UNITE/$result.UNITE.krona


echo \
"Kraken Released!"


exit 0