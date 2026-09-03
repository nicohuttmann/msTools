# msTools

A data-focused library of functions to analyze, visualize and report
proteomics data.

# Installation

You can install this package from GitHub via:

    devtools::install_github("nicohuttmann/msTools")

or the new, fast way:

    pak::pkg_install("nicohuttmann/msTools")

msTools sits on top of
[msArrow](https://nicohuttmann.github.io/msArrow/), which provides the
on-disk storage: data is written to parquet or delimited files and
referenced by path rather than held in memory.

# The dataset store

A dataset keeps three things together on disk — **variables**
(precursors, peptides, protein groups), **observations** (runs, samples)
and any number of long `observations x variables` **data frames**:

``` r

library(msTools)

import_diann("report.parquet", name = "Precursors", save_dir = "Data/RData")

get_variables_data("Genes", dataset = "Precursors")
get_observations_data("Condition", dataset = "Precursors")
get_data_frame("Precursor.Normalised", dataset = "Precursors")
```

The registry lives in two objects in the global environment: `.Datasets`
holds file paths, `Datasets` holds small previews, so nothing large sits
in the session.

# What else is here

|  |  |
|----|----|
| Reshaping | [`tibble2matrix()`](https://nicohuttmann.github.io/msTools/reference/tibble2matrix.md), [`transpose_tibble()`](https://nicohuttmann.github.io/msTools/reference/transpose_tibble.md) and the [`t2m()`](https://nicohuttmann.github.io/msTools/reference/t2m.md)/[`m2t()`](https://nicohuttmann.github.io/msTools/reference/m2t.md) shorthands |
| Plotting | [`pdf_()`](https://nicohuttmann.github.io/msTools/reference/pdf_.md) and friends, [`add_n()`](https://nicohuttmann.github.io/msTools/reference/add_n.md), [`set_continuous_axes()`](https://nicohuttmann.github.io/msTools/reference/set_continuous_axes.md) |
| Reports | [`button_begin()`](https://nicohuttmann.github.io/msTools/reference/button_begin.md), [`html_justify()`](https://nicohuttmann.github.io/msTools/reference/html_justify.md), [`plot_tabset()`](https://nicohuttmann.github.io/msTools/reference/plot_tabset.md) |
| Strings | [`strsplit_keep_first()`](https://nicohuttmann.github.io/msTools/reference/strsplit_keep_first.md), [`str_locate_last()`](https://nicohuttmann.github.io/msTools/reference/str_locate_last.md) |
| Small tools | [`cc()`](https://nicohuttmann.github.io/msTools/reference/cc.md), [`fu()`](https://nicohuttmann.github.io/msTools/reference/fu.md), [`fus()`](https://nicohuttmann.github.io/msTools/reference/fus.md), [`cleanup()`](https://nicohuttmann.github.io/msTools/reference/cleanup.md) |

See the [reference](https://nicohuttmann.github.io/msTools/reference/)
for the full list.
