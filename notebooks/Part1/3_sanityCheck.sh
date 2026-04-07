echo "=== FASTQ files ==="
ls -lh /sharedFolder/fastq/*.fastq.gz | awk '{print $5, $9}'

echo ""
echo "=== Reference ==="
echo "Genome size: $(du -sh /sharedFolder/reference/genome.fa | cut -f1)"
echo "GTF size:    $(du -sh /sharedFolder/reference/annotation.gtf | cut -f1)"

echo ""
echo "=== Number of chromosomes in genome ==="
grep -c "^>" /sharedFolder/reference/genome.fa
zcat /sharedFolder/fastq/SRR031714_1.fastq.gz | awk 'NR%4==2 {print length($0)}' | sort -nu