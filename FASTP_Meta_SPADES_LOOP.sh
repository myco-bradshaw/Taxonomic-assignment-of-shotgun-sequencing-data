#!/bin/bash

####==========================================================================
#### STEP 2 - Genome Assembly [Spades] & Adapter Trimming [FASTP]
####==========================================================================

####==========================================================================
#---------------------------DETERMINE FILE NAMES------------------------------
####==========================================================================
#use the term that is most correct for your read type
fullname=$(basename $1)
filename1=${fullname%_1*.fastq.gz}
filename2=${fullname%_i5*.fastq.gz}
filename3=${filename2#*_}
filename4=${filename3%%_i5*}
filename=${fullname%%_*}

echo ${fullname}
echo ${filename1}
echo ${filename2}
echo ${filename3}
echo ${filename4}
echo ${filename}


####==========================================================================
#--------------------------------ADAPTER REMOVAL-------------------------------
####==========================================================================

#AdapterRemoval --threads 72 --file1 ./${filename}_pass_1.fastq.gz --file2 ./${filename}_pass_1.fastq.gz --qualitymax 45 --basename ${filename} --trimns --trimqualities --gzip


####==========================================================================
#---------------------------MAKE ANALYSIS DIRECTORIES--------------------------
####==========================================================================

[ -d Meta_Spades_assemblies ] || mkdir Meta_Spades_assemblies
[ -d trimmed ] || mkdir trimmed

####==========================================================================
#-------------------------------SPADES_ASSEMBLY-------------------------------
####==========================================================================


#This step automatically looks at the files within your directory and trims reads if they exist or moves directly to assmbly if reads are already trimmed


if  [ -f ./trimmed/${filename}_trimmed.1.fastq.gz ]
then
        echo "trimmed reads exist"
        python /home/abradshaw/SPAdes-3.14.0-dev/bin/metaspades.py --pe1-1 ./trimmed/${filename}_trimmed.1.fastq.gz \
        --pe1-2 ./trimmed/${filename}_trimmed.2.fastq.gz \
        -t 72 -m 750 \
        -k 77,85,99,111,127 \
        -o ./Meta.Spades_assemblies/${filename}
else
        echo "trimmed reads don't exist"
       /home/bdentinger/fastp -i ${filename}_R1_001.fastq.gz -I ${filename}_R2_001.fastq.gz -o ./trimmed/${filename}_trimmed.1.fastq.gz -O \
         ./trimmed/${filename}_trimmed.2.fastq.gz --detect_adapter_for_pe --thread 16
       python /home/abradshaw/SPAdes-3.14.0-dev/bin/metaspades.py --pe1-1 ./trimmed/${filename}_trimmed.1.fastq.gz \
        --pe1-2 ./trimmed/${filename}_trimmed.2.fastq.gz \
        -t 72 \
        -k 77,85,99,111,127 \
        -o ./Meta.Spades_assemblies/${filename}
fi

echo ---------DONE----------


exit 0

