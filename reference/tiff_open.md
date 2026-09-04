# Title

Title

## Usage

``` r
tiff_open(file)
```

## Arguments

- file:

  tiff file to open (opens file saved under .tiff_temp if no argument
  given)

## Examples

``` r
tiff_temp()
plot(6, 9)
tiff_open
#> function (file) 
#> {
#>     while (length(dev.list() != 0)) dev.off()
#>     if (!hasArg(file) && !exists(".tiff_temp")) {
#>         message("Nothing to open.")
#>         return(invisible(F))
#>     }
#>     else if (hasArg(file)) {
#>         system(paste0("open \"", file, "\""))
#>         return(invisible(T))
#>     }
#>     else {
#>         system(paste0("open \"", .tiff_temp, "\""))
#>         return(invisible(T))
#>     }
#> }
#> <bytecode: 0x557145a31098>
#> <environment: namespace:msTools>
```
