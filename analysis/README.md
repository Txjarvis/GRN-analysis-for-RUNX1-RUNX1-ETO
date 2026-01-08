# GRN network analysis

This directory contains the R file used for downstream analysis and visualisation of the gene regulatory networks (GRNs) generated for
0Dox and 5Dox conditions.

These analyses are done on the Cytoscape analyser (node and edge tables) and are used to generate figures

---

## Contents

### `Analysis_clean.Rmd`

- Performs analysis of GRN structure
- Calculates and visualises:
  - In-degree and out-degree distributions
  - Betweenness centrality
  - Condition-specific changes in TF regulatory influence
- Aggregates network properties by transcription factor motif family

---

## Notes

- The CSV file is included for ease of replication


