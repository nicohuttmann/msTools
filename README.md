# msTools

<!-- badges: start -->
[![R-CMD-check](https://github.com/nicohuttmann/msTools/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/nicohuttmann/msTools/actions/workflows/R-CMD-check.yaml)
[![pkgdown](https://github.com/nicohuttmann/msTools/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/nicohuttmann/msTools/actions/workflows/pkgdown.yaml)
<!-- badges: end -->

A data-focused library of functions to analyze, visualize and report proteomics data. 

# Installation
You can install this package from GitHub via:

```
devtools::install_github("nicohuttmann/msTools")
```

or the new, fast way: 

```
pak::pkg_install("nicohuttmann/msTools")
```

msTools sits on top of [msArrow](https://nicohuttmann.github.io/msArrow/),
which provides the on-disk storage: data is written to parquet or delimited
files and referenced by path rather than held in memory.

# The dataset store

A dataset keeps three things together on disk — **variables** (precursors,
peptides, protein groups), **observations** (runs, samples) and any number of
long `observations x variables` **data frames**:

```r
library(msTools)

import_diann("report.parquet", name = "Precursors", save_dir = "Data/RData")

get_variables_data("Genes", dataset = "Precursors")
get_observations_data("Condition", dataset = "Precursors")
get_data_frame("Precursor.Normalised", dataset = "Precursors")
```

The registry lives in two objects in the global environment: `.Datasets` holds
file paths, `Datasets` holds small previews, so nothing large sits in the
session.

# What else is here

| | |
|---|---|
| Reshaping | `tibble2matrix()`, `transpose_tibble()` and the `t2m()`/`m2t()` shorthands |
| Plotting | `pdf_()` and friends, `add_n()`, `set_continuous_axes()` |
| Reports | `button_begin()`, `html_justify()`, `plot_tabset()` |
| Strings | `strsplit_keep_first()`, `str_locate_last()` |
| Small tools | `cc()`, `fu()`, `fus()`, `cleanup()` |

See the [reference](https://nicohuttmann.github.io/msTools/reference/) for the
full list.
