
cd ../Caso1

mkdir Merged

### 1 - Merge the filtered samples
~/usearch -fastq_mergepairs Muestras_filtradas/*R1* -maxdiffs 5 -fastqout Merged/merged.fastq

## If samples are single end, we can join all of them in one file. We store them all in one folder and:
## for file in [Folder]/*.fastq; do cat $file >> [File_name].fastq

### 2 - Create the report
~/usearch -fastx_info Merged/merged.fastq -output Merged/Stats_merge.txt

### 3 - Remove primers of amplification
~/usearch -fastx_truncate Merged/merged.fastq -stripleft 20 -stripright 20 -fastqout Merged/truncated.fastq

### 4 - Filter the samples
~/usearch -fastq_filter Merged/truncated.fastq -fastaout Merged/filtered.fa -relabel filt -fastq_maxee 1 -fastq_minlen 200

### 5 - Stay with the uniques
~/usearch -fastx_uniques Merged/filtered.fa -fastaout Merged/uniques.fasta -sizeout -relabel Uniq -strand both
