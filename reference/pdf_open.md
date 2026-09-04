# Title

Title

## Usage

``` r
pdf_open(file)
```

## Arguments

- file:

  pdf file to open (opens file saved under .pdf_temp if no argument
  given)

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
#> <bytecode: 0x557145314590>
#> <environment: namespace:msTools>
```
