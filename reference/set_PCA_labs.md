# Add PCA axis labels (with % variance) to a ggplot (`+`-able)

Add to a ggplot with `+`, e.g. `p + set_PCA_labs()`.

## Usage

``` r
set_PCA_labs(PCx = NULL, PCy = NULL, sdev = NULL, digits = 1)
```

## Arguments

- PCx, PCy:

  principal component numbers; inferred from the plot mapping if omitted

- sdev:

  vector of PC standard deviations; computed from the plot data if
  omitted

- digits:

  digits for the rounded percentage

## Value

an object to be added to a ggplot with `+`
