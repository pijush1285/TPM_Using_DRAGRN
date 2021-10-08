#!/bin/bash

#Reference genome and the gtf files were downloaded from the link given below.
#https://hgdownload.soe.ucsc.edu/downloads.html#human


#For hashing the reference genome here Hg19
# dragen \
# --build-hash-table true \
# --ht-build-rna-hashtable true \
# --ht-reference /data1/ngc/dragen1/AmitavaSengupta/reference/human/hg19/hg19.fa \
# --output-dir /data1/ngc/dragen1/AmitavaSengupta/reference/human/hg19/hash \
# --ht-alt-liftover /opt/edico/liftover/hg19_alt_liftover.sam \
# --ht-alt-aware-validate=false


dragen -l \
-r /data1/ngc/dragen1/AmitavaSengupta/reference/human/hg19/hash

#No permissio for this hash table
#dragen -l \
#-r /staging/human/reference/hg19/hg19.fa.k_21.f_16.m_149



for L in 1
do

  if [ $L == 1 ]
  then
      #File input_fileLocation
      input_fileLocation=/data1/ngc/dragen1/AmitavaSengupta/RNA_IICB_A.Sengupta/H1
      echo "1st Sample set is choosen."
  fi
  if [ $L == 2 ]
  then
      #File input_fileLocation
      input_fileLocation=/data1/ngc/dragen1/AmitavaSengupta/RNA_IICB_A.Sengupta/H2
      echo "2nd Sample set is choosen."
  fi
  if [ $L == 3 ]
  then
      #File input_fileLocation
      input_fileLocation=/data1/ngc/dragen1/AmitavaSengupta/RNA_IICB_A.Sengupta/H3
      echo "3rd Sample set is choosen."
  fi
  if [ $L == 4 ]
  then
      #File input_fileLocation
      input_fileLocation=/data1/ngc/dragen1/AmitavaSengupta/RNA_IICB_A.Sengupta/H4
      echo "4th Sample set is choosen."
  fi
  if [ $L == 5 ]
  then
      #File input_fileLocation
      input_fileLocation=/data1/ngc/dragen1/AmitavaSengupta/RNA_IICB_A.Sengupta/H5
      echo "5th Sample set is choosen."
  fi


#Output results location.
output_resultLocation=/data1/ngc/dragen1/AmitavaSengupta/processed

##################################################################################

count=0
for entry in "$input_fileLocation"/*.gz
do
  echo "$entry"
  array[$count]="$entry"
  count=$(($count+1))
  echo $count
done


r1=${array[0]}
r2=${array[1]}


echo $r1
echo $r2


#####################################################################################

word=$(awk -F/ '{print $8}' <<< "${array[0]}")
echo $word
prefix=$(awk -F_ '{print $1}' <<< "${word}")_$(awk -F_ '{print $2}' <<< "${word}")
echo $prefix
nDir=$(awk -F_ '{print $1}' <<< "${word}")
echo $nDir

#Create a new Directory in the result folder
mkdir $output_resultLocation/$nDir
echo "Directory created:"
cd $output_resultLocation/$nDir
echo "Directory changed:"


#####################################################################################
#Code from Kuntal.
dragen -f \
-r /data1/ngc/dragen1/AmitavaSengupta/reference/human/hg19/hash \
-1 $r1 \
-2 $r2 \
--output-directory $output_resultLocation/$nDir \
--RGID NovaSeq \
--RGSM $nDir \
--output-file-prefix $nDir \
--enable-rna true \
-a /data1/ngc/dragen1/AmitavaSengupta/reference/human/gtf/hg19.refGene.gtf \
--enable-rna-quantification true


done
