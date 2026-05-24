# Microbial interaction network inference

This repository contains synthetic benchmark datasets for microbial interaction network inference.

---

## Repository Structure

```text
├── test_data
│   ├── dataset_1
│   │   ├── adj.csv
│   │   └── count_table.csv
│   ├── dataset_10
│   │   ├── adj.csv
│   │   └── count_table.csv
│   ├── dataset_2
│   │   ├── adj.csv
│   │   └── count_table.csv
│   ├── dataset_3
│   │   ├── adj.csv
│   │   └── count_table.csv
│   ├── dataset_4
│   │   ├── adj.csv
│   │   └── count_table.csv
│   ├── dataset_5
│   │   ├── adj.csv
│   │   └── count_table.csv
│   ├── dataset_6
│   │   ├── adj.csv
│   │   └── count_table.csv
│   ├── dataset_7
│   │   ├── adj.csv
│   │   └── count_table.csv
│   ├── dataset_8
│   │   ├── adj.csv
│   │   └── count_table.csv
│   └── dataset_9
│       ├── adj.csv
│       └── count_table.csv
└── validation_data
    ├── dataset_1
    │   └── count_table.csv
    ├── dataset_2
    │   └── count_table.csv
    └── dataset_3
        └── count_table.csv
```

---

## Test data folder

This folder contains 10 datasets that you can use to develop and validate your inference pipeline. Each `dataset_x` folder contains:

1. `count_table.csv` is a .csv file containing a matrix (samples x taxa) with the abundance of the taxa in the various samples (input for the network inference algorithms).
2. `adj.csv` a csv file containing an adjacecnty matrix (taxa x taxa) representing the ground truth interaction network that generated the count data in `count_table.csv` (can be used to assess the inference results). Entries are binary: `1` = edge present, `0` = edge absent

Each dataset represent a commuinty generated with different characteristis that may inpact network inference algorithms' performances.

## Validation data folder

This folder contains the 3 datasets on which you will be evaluated for the challenge. Each `dataset_x` folder contains:

1. `count_table.csv` is a .csv file containing a matrix (samples x taxa) with the abundance of the taxa in the various samples (input for the network inference algorithms).
  
---

## Instruction for the challenge

In order to be evaluated and effectively complete the challenge, you will need:

1. Produce 3 text files, one for each validation dataset, containing the adjacency matrix of the inferred interaction network.
2. The file can have whatever table-like format that you like (.tsv, .csv, .txt, …), but need to represent a binary and symmetric adjacency matrix.
3. Each row and each column in the result file MUST be named after the taxa that it refers to, taking the names from in the corresponding count_table.csv file (they will look something like TAXA_1, TAXA_2, …)
4. The columns and rows in the result files CAN be in a different order with respect to the one in the count table (but keeping them in the correct order is appreciated)
5. Missing columns or rows will be considered as zero entries! This can considerably penalise you in the evaluation, so be careful

That's all, have fun!

---

## Notes

- The benchmark focuses on static graph recovery.
- Time-series datasets are not included.
- The gold standard networks are provided as symmetric adjacency matrices.
