#!/bin/bash

#Reference genome and the gtf files were downloaded from the link given below.
#https://hgdownload.soe.ucsc.edu/downloads.html#human

#Hash table for mouse mm10 genome
dragen \
--build-hash-table true \
--ht-build-rna-hashtable true \
--ht-reference /data1/ngc/dragen1/AmitavaSengupta/reference/mouse/mm10/mm10.fa \
--output-dir /data1/ngc/dragen1/AmitavaSengupta/reference/mouse/mm10/hash

dragen -l \
-r /data1/ngc/dragen1/AmitavaSengupta/reference/mouse/mm10/hash



for L in 2 3 4 5 6 7 8
do

  if [ $L == 1 ]
  then
      #File input_fileLocation
      input_fileLocation=/data1/ngc/dragen1/AmitavaSengupta/RNA_IICB_A.Sengupta/1
      echo "1st Sample set is choosen."
  fi
  if [ $L == 2 ]
  then
      #File input_fileLocation
      input_fileLocation=/data1/ngc/dragen1/AmitavaSengupta/RNA_IICB_A.Sengupta/2
      echo "2nd Sample set is choosen."
  fi
  if [ $L == 3 ]
  then
      #File input_fileLocation
      input_fileLocation=/data1/ngc/dragen1/AmitavaSengupta/RNA_IICB_A.Sengupta/3
      echo "3rd Sample set is choosen."
  fi
  if [ $L == 4 ]
  then
      #File input_fileLocation
      input_fileLocation=/data1/ngc/dragen1/AmitavaSengupta/RNA_IICB_A.Sengupta/4
      echo "4th Sample set is choosen."
  fi
  if [ $L == 5 ]
  then
      #File input_fileLocation
      input_fileLocation=/data1/ngc/dragen1/AmitavaSengupta/RNA_IICB_A.Sengupta/5
      echo "5th Sample set is choosen."
  fi
  if [ $L == 6 ]
  then
      #File input_fileLocation
      input_fileLocation=/data1/ngc/dragen1/AmitavaSengupta/RNA_IICB_A.Sengupta/6
      echo "5th Sample set is choosen."
  fi
  if [ $L == 7 ]
  then
      #File input_fileLocation
      input_fileLocation=/data1/ngc/dragen1/AmitavaSengupta/RNA_IICB_A.Sengupta/7
      echo "5th Sample set is choosen."
  fi
  if [ $L == 8 ]
  then
      #File input_fileLocation
      input_fileLocation=/data1/ngc/dragen1/AmitavaSengupta/RNA_IICB_A.Sengupta/8
      echo "5th Sample set is choosen."
  fi


#Output results location.
output_resultLocation=/data1/ngc/dragen1/AmitavaSengupta/processed/mouse

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
-r /data1/ngc/dragen1/AmitavaSengupta/reference/mouse/mm10/hash \
-1 $r1 \
-2 $r2 \
--output-directory $output_resultLocation/$nDir \
--RGID NovaSeq \
--RGSM $nDir \
--output-file-prefix $nDir \
--enable-rna true \
-a /data1/ngc/dragen1/AmitavaSengupta/reference/mouse/gtf/mm10.refGene.gtf \
--enable-rna-quantification true


echo "##########################################################################"
echo "Sample:" $L "compleated"
echo "##########################################################################"
done



###################################################################################################
# FPKM Analysis from the mapped bam file for read count generation.
# This will be used for differential expression analysis.
###################################################################################################

gtf=/data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/gtf/mouse/gtf/mm10.refGene.gtf
input_bam=/data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/processed/mouse/1/1.bam

cd /data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/FPKM/mouse/1
stringtie $input_bam -p 25 -G $gtf -o 1.FPKM.gtf -e -B

echo "##############################################################################"
echo " Sample 1	compleated."
echo "##############################################################################"



gtf=/data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/gtf/mouse/gtf/mm10.refGene.gtf
input_bam=/data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/processed/mouse/2/2.bam

cd /data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/FPKM/mouse/2
stringtie $input_bam -p 25 -G $gtf -o 2.FPKM.gtf -e -B

echo "##############################################################################"
echo " Sample 2	compleated."
echo "##############################################################################"



gtf=/data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/gtf/mouse/gtf/mm10.refGene.gtf
input_bam=/data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/processed/mouse/3/3.bam

cd /data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/FPKM/mouse/3
stringtie $input_bam -p 25 -G $gtf -o 3.FPKM.gtf -e -B

echo "##############################################################################"
echo " Sample 3	compleated."
echo "##############################################################################"


gtf=/data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/gtf/mouse/gtf/mm10.refGene.gtf
input_bam=/data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/processed/mouse/4/4.bam

cd /data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/FPKM/mouse/4
stringtie $input_bam -p 25 -G $gtf -o 4.FPKM.gtf -e -B

echo "##############################################################################"
echo " Sample 4	compleated."
echo "##############################################################################"



gtf=/data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/gtf/mouse/gtf/mm10.refGene.gtf
input_bam=/data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/processed/mouse/5/5.bam

cd /data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/FPKM/mouse/5
stringtie $input_bam -p 25 -G $gtf -o 5.FPKM.gtf -e -B

echo "##############################################################################"
echo " Sample 5	compleated."
echo "##############################################################################"



gtf=/data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/gtf/mouse/gtf/mm10.refGene.gtf
input_bam=/data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/processed/mouse/6/6.bam

cd /data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/FPKM/mouse/6
stringtie $input_bam -p 25 -G $gtf -o 6.FPKM.gtf -e -B

echo "##############################################################################"
echo " Sample 6	compleated."
echo "##############################################################################"


gtf=/data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/gtf/mouse/gtf/mm10.refGene.gtf
input_bam=/data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/processed/mouse/7/7.bam

cd /data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/FPKM/mouse/7
stringtie $input_bam -p 25 -G $gtf -o 7.FPKM.gtf -e -B

echo "##############################################################################"
echo " Sample 7	compleated."
echo "##############################################################################"


gtf=/data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/gtf/mouse/gtf/mm10.refGene.gtf
input_bam=/data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/processed/mouse/8/8.bam

cd /data/sata_data/workshop/wsu28/NGC/RNA_IICB_A.Sengupta/FPKM/mouse/8
stringtie $input_bam -p 25 -G $gtf -o 8.FPKM.gtf -e -B

echo "##############################################################################"
echo " Sample 8	compleated."
echo "##############################################################################"

#For read count the code is given below.

path=/data/sata_data/workshop/wsu28/anaconda3/envs/pdas/bin
python $path/prepDE.py -i mouse
