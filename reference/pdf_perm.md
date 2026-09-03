# Opens a permanent pdf device

Opens a permanent pdf device

## Usage

``` r
pdf_perm(file, width = 5, height = 5, dir, ...)
```

## Arguments

- file:

  file name (required; use
  [`pdf_temp()`](https://nicohuttmann.github.io/msTools/reference/pdf_temp.md)
  for a temporary file)

- width:

  the width of the graphics region in inches (default = 5)

- height:

  the height of the graphics region in inches (default = 5)

- dir:

  (optional) folder name, if easier to give separately from the file

- ...:

  additional parameters for pdf()

## Value

the file path (invisibly); the device is left open

## Examples

``` r
pdf_temp()
plot(6, 9)
pdf_open
#> function (file) 
#> {
#>     while (length(dev.list() != 0)) dev.off()
#>     if (!hasArg(file) && !exists(".pdf_temp")) {
#>         message("Nothing to open.")
#>         return(invisible(F))
#>     }
#>     else if (hasArg(file)) {
#>         system(paste0("open \"", file, "\""))
#>         return(invisible(T))
#>     }
#>     else {
#>         system(paste0("open \"", .pdf_temp, "\""))
#>         return(invisible(T))
#>     }
#> }
#> <bytecode: 0x5562a76da2c0>
#> <environment: namespace:msTools>
```
