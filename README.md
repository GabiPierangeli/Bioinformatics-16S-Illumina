# Bioinformatics-16S-Illumina
This repository has files for bioinformatics steps with 16S rDNA gene sequences obtained by the Illumina platform. Some scripts also work for shotgun Illumina sequencing preprocessing as well. Scripts were designed by Gustavo B. Gregoracci (gregoracci@unifesp,br) - DCMar - IMar - UNIFESP BS - Brazil

#sizecutterlinux.pl
  USAGE: perl sizecutterlinux.pl <filename>.fastq
  DESCRITPION: This script reads a fastq file, line by line, measure each sequence and copies the ones that are above a given cuttoff size. Default is 75 bp for a 2x250bp or 2x300 bp Illumina run. When processing a 2x100bp Illumina run, it is necssary to alter the script to 40 bp cuttoff. Editing the file in notepad is enough. The script will generate a .cut.fastq file. This should work on any fastq files.
  
#fastqtofasta.pl
  USAGE: perl fastqtofasta.pl <filename>.fastq
  DESCRITPION: This script reads a fastq file, line by line, and copies the first two lines into a new fasta file. This should work on any fastq files. 
 
#txttofastalinux.pl
  USAGE*: perl txttofastalinux.pl <filename>.txt
  DESCRITPION: This script converts the singlets txt file generated by Pandaseq to fasta. The singlets file is a fasta file with a dash connecting forward and reverse seqs. Since dash represents a problem for fasta files, the script basically removes the dash.
  
#renameheaders.pl
  USAGE: perl renameheaders.pl <filename>.fasta
  DESCRITPION: Since Illumina default headers are long and full of symbols, they sometimes are not compatible with some programs. This script changes the long code for a <Filename>.Seq# header. It generates a fasta file with the new headers and a legend.txt file with both the new and original header. It ran on all downstream aplications we used. This should work on any fasta files.
  
#uniqueseqsv2.pl
  USAGE: perl uniqueseqsv2.pl <filename>.fasta
  DESCRITPION: This script checks a fasta file for exact duplicate entries. It checks whether seqs are the same in the four possible orientations (direct, reverse, complement and reverse complement); if any one gets a match, one sequence is kept and the total count is added up. Only exact matches are evaluated! It produces a new fasta with unique entries (and their new counts are added to the header), and a txt list of all headers joined together. This should work on any fasta files, but it is recommended only for amplicon sequences. This is not recommended for shotgun sequencing.
  
#checkforseqswithN.pl
  USAGE: perl checkforseqswithN.pl <filename>.fasta
  DESCRITPION: This script removes sequences which contain any base except the four standard (A,T,G,C). Usually some poor quality seqs retain Ns in our runs, but Ns are incompatible with some downstream softwares. So this script will copy seqs without N and count the total seqs removed. This should work on any fasta file.
  
#taxsummarytoexcel.pl 
  USAGE: perl taxsummarytoexcel.pl <filename>.txt
  DESCRITPION: mothur wang annotation provides a tax.summary file which is easily readable by machines but not so easily by humans. This script converts the table into a more human readable one, namely a tsv file, easily opened into excel or libreoffice.
