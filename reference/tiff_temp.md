# Title

Title

## Usage

``` r
tiff_temp(..., width = 10, height = 5, units = "cm", res = 300)
```

## Arguments

- ...:

  additional parameters for tiff()

- width:

  the width of the graphics region in the given unit (default = 10)

- height:

  the height of the graphics region in the given unit (default = 5)

- units:

  The units in which height and width are given. Can be cm (default),
  mm, px (pixels) or in (inches)

- res:

  the resolution in ppi

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
