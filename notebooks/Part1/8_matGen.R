library(Rsubread)

align_dir <- "/sharedFolder/alignments"
gtf_file <- "/sharedFolder/reference/annotation.gtf"
out_dir <- "/sharedFolder/counts"

dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

bam_files <- list.files(
  path = align_dir,
  pattern = "\\.Aligned\\.sortedByCoord\\.out\\.bam$",
  full.names = TRUE
)

cat("=== BAM files used for counting ===\n")
print(bam_files)

fc <- featureCounts(
  files = bam_files,
  annot.ext = gtf_file,
  isGTFAnnotationFile = TRUE,
  GTF.featureType = "exon",
  GTF.attrType = "gene_id",
  useMetaFeatures = TRUE,
  isPairedEnd = TRUE,
  countReadPairs = TRUE,
  nthreads = 4
)

write.table(
  fc$counts,
  file = file.path(out_dir, "gene_counts_matrix.txt"),
  sep = "\t",
  quote = FALSE,
  col.names = NA
)

summary_table <- data.frame(
  Sample = names(fc$stat),
  Assigned = fc$stat["Assigned", ],
  Unassigned_Unmapped = fc$stat["Unassigned_Unmapped", ],
  Unassigned_MultiMapping = fc$stat["Unassigned_MultiMapping", ],
  Unassigned_NoFeatures = fc$stat["Unassigned_NoFeatures", ],
  check.names = FALSE
)

write.table(
  summary_table,
  file = file.path(out_dir, "featureCounts_summary.txt"),
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)

cat("\n=== Counting completed ===\n")
cat("Count matrix: ", file.path(out_dir, "gene_counts_matrix.txt"), "\n", sep = "")
cat("Summary: ", file.path(out_dir, "featureCounts_summary.txt"), "\n", sep = "")