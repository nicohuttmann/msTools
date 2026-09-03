# Removes objects from the global environment

Everything in the global environment is removed except the dataset
registry (`Analysis`, `Datasets`, `Info`) and anything named in , so a
long session can be cleared without losing the attached datasets.

## Usage

``` r
cleanup(exclude = c())
```

## Arguments

- exclude:

  names of further objects to keep

## Value

"Good job." (invisibly)

## Examples

``` r
  x <- 1
  cleanup(exclude = "x")
```
