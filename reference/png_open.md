# Title

Title

## Usage

``` r
png_open(file)
```

## Arguments

- file:

  png file to open (opens file saved under .png_temp if no argument
  given)

## Examples

``` r
png_temp()
plot(6, 9)
png_open
#> function (file) 
#> {
#>     while (length(dev.list() != 0)) dev.off()
#>     if (!hasArg(file) && !exists(".png_temp")) {
#>         message("Nothing to open.")
#>         return(invisible(F))
#>     }
#>     else if (hasArg(file)) {
#>         system(paste0("open \"", file, "\""))
#>         return(invisible(T))
#>     }
#>     else {
#>         system(paste0("open \"", .png_temp, "\""))
#>         return(invisible(T))
#>     }
#> }
#> <bytecode: 0x557145bbe458>
#> <environment: namespace:msTools>
```
