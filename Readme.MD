# BioHackathon BITS 2026

**2° International BioHackathon of BITS** — Padova, May 26–27 2026

---

## Overview

Welcome to the official repository of the BioHackathon BITS 2026!

This repository contains all the data and instructions needed to participate in the hackathon. Each group is expected to develop bioinformatics pipelines for **two network inference tasks**:

- **Task 1** — Reverse engineering of bacterial interaction networks (Metagenomics)
- **Task 2** — Reverse engineering of gene regulatory networks (Transcriptomics)

Clone this repository to get started:

```bash
git clone https://github.com/younginfolife/BiohackathonBITS2026
```

---

## Schedule

| Session | Date | Time |
|---------|------|------|
| Session 1 | Tuesday, May 26 2026 | 14:30 – 18:30 |
| Session 2 | Wednesday, May 27 2026 | 08:30 – 12:30 |

---

## Repository Structure

```text
BiohackathonBITS2026/
├── MetaGenomics_Dataset/        ← Task 1 data
│   ├── dataset_1/
│   │   ├── count_table.csv      ← Input: raw abundance matrix (samples × taxa)
│   │   └── adj.csv              ← Ground truth adjacency matrix (taxa × taxa)
│   ├── dataset_2/
│   │   └── ...
│   └── ... (dataset_1 through dataset_10)
│
├── Trascriptomics_Dataset/      ← Task 2 data
│   ├── Data/                    ← Input expression matrices (samples × genes, TSV)
│   │   ├── insilico_size100_1_multifactorial.tsv
│   │   ├── insilico_size100_1_knockdowns.tsv
│   │   ├── insilico_size100_1_knockouts.tsv
│   │   └── ...
│   └── Gold standard/           ← Ground truth adjacency matrices (genes × genes, TSV)
│       ├── insilico_size100_1_goldstandard_matrix.tsv
│       └── ...
│
├── BioHackathon_2026_Instruction.pptx   ← Full instructions slide deck
└── README.md
```

> **Note:** Evaluation datasets are **not** included in this repository. They will be used only by the organizers to score your submitted pipelines.

---

## Tasks

### Task 1 — Reverse Engineering of Bacterial Interaction Networks

**Data folder:** `MetaGenomics_Dataset/`

Starting from raw microbial abundance count data, you must develop a pipeline that:

1. Preprocesses the count data (e.g. normalization, zero imputation, data transformation) if needed
2. Infers the bacterial interaction network
3. Outputs a binary symmetric adjacency matrix describing the inferred interaction graph

Each `dataset_x/` folder contains:

| File | Description |
|------|-------------|
| `count_table.csv` | Input matrix — rows: samples, columns: taxa (e.g. `TAXA_1`, `TAXA_2`, …) |
| `adj.csv` | Ground truth adjacency matrix — use this to assess your pipeline's performance |

You have **10 test datasets** to develop and validate your pipeline.

---

### Task 2 — Reverse Engineering of Gene Regulatory Networks

**Data folder:** `Trascriptomics_Dataset/`

Starting from gene expression data, you must develop a pipeline that infers the underlying gene regulatory network.

The `Data/` folder contains expression matrices in TSV format, where rows are samples/perturbation experiments and columns are genes. Three experimental types are available: multifactorial, knockdowns, and knockouts.

The `Gold standard/` folder contains the corresponding reference adjacency matrices (genes × genes, binary, symmetric), to be used to assess your results.

The naming convention links datasets to their gold standard:

```
Data/insilico_size100_1_multifactorial.tsv  →  Gold standard/insilico_size100_1_goldstandard_matrix.tsv
Data/insilico_size100_2_knockdowns.tsv      →  Gold standard/insilico_size100_2_goldstandard_matrix.tsv
```

You have **10 test datasets** to develop and validate your pipeline.

---

## Output Format

For both tasks, the required output is a **binary, symmetric adjacency matrix**. The same format applies to test (self-evaluation) and evaluation (submission) datasets.

**Requirements:**

- The file can be in any table-like format: `.csv`, `.tsv`, `.txt`, etc.
- The matrix must be **binary** (`1` = edge present, `0` = edge absent) and **symmetric**
- Every **row and column must be named** after the corresponding taxon/gene, using the exact names from the input file (e.g. `TAXA_1`, `TAXA_2`, … or `G1`, `G2`, …)
- Row/column order can differ from the input, but keeping the original order is appreciated
- ⚠️ **Missing rows or columns will be treated as zeros** — this will significantly penalise your score, so double-check completeness before submitting

**Example (CSV format):**

```
,TAXA_1,TAXA_2,TAXA_3
TAXA_1,0,1,0
TAXA_2,1,0,1
TAXA_3,0,1,0
```

---

## Evaluation

Each group will be evaluated **on both tasks** using evaluation datasets that are not included in this repository.

Performance will be assessed using a combination of metrics (e.g. precision, recall, F1 score, AUROC). A balance across metrics is recommended — optimising for only one may penalise you on others.

---

## Submission

Each group must submit the following for **each task**:

1. **A Markdown file** describing the developed pipeline (methods, rationale, tools used)
2. **The inferred adjacency matrices** for each evaluation dataset, following the output format described above

> 📬 **Submission link:** `[TO BE ADDED]`

---

## Computational Resources

In addition to your own laptop, each group has access to a **remote Virtual Machine (VM)** kindly provided by HPC4AI.

> 🖥️ **VM access:** `[TO BE ADDED]`
>
> **Instructions:**
> ```
> [TO BE ADDED — or see dedicated PDF if provided]
> ```

Each VM has pre-installed software, but participants are free to install any additional tools they need.

### Pre-installed R packages

#### Metagenomics (Task 1)

| Category | Packages |
|----------|----------|
| Normalization | GMPR, CSS, RCSS, TMM |
| Zero imputation | scImpute, drImpute, MBimpute |
| Data transformation | CLR (via `microbiome`) |
| Network inference | SPRING, SPIEC-EASI, CCLASSO |

#### Transcriptomics (Task 2)

| Category | Packages |
|----------|----------|
| Network inference | huge, glasso, GENIE3, SPACE, GeneNet, C3Net, WGCNA, minet, qgraph, BDgraph |

---

## WiFi

| Option | Details |
|--------|---------|
| Eduroam | Use your institutional credentials |
| Ad-hoc network | Network: `zona01-unipd` · Username: `BioHack2026` · Password: `[TO BE ADDED]` |

---

## Notes

- The benchmark focuses on **static graph recovery** — time-series datasets are not included
- Gold standard networks are provided as **symmetric adjacency matrices**
- Participants are free to use any tool, language, or library beyond what is pre-installed on the VM
- Questions? Ask the organizers during the sessions

---

*Good luck and have fun! 🚀*
