#' Bootstrap button to hide/show segments
#'
#' @param label
#'
#' @returns
#' @export
#'
#' @examples
button_begin <- function(label = "View/Hide") {
  if (!exists(".n.button")) .n.button <<- 0
  .n.button <<- .n.button + 1

  code <- paste0('<button class="btn btn-primary" type="button" ',
                 'data-bs-toggle="collapse" data-bs-target="#button',
                 .n.button,
                 '" aria-expanded="false" aria-controls="button',
                 .n.button,
                 '"> ', label,
                 ' </button> <div id="button',
                 .n.button,
                 '" class="collapse">  ')
  return(noquote(code))
}


#' Bootstrap button to hide/show segments - simple div to end button
#'
#' @returns
#' @export
#'
#' @examples
button_end <- function() {
  return(noquote('</div>'))
}


#' Justify following text
#'
#' @returns
#' @export
#'
#' @examples
html_justify <- function() {
  if (knitr::is_html_output())
    return(noquote("<style>\nbody {\ntext-align: justify}\n</style>"))
  else return(noquote(""))
}


#' Plot the markdown code for individual tabsets
#'
#' @param .x verctor to iterate through for each tabset panel
#' @param .pf plotting function
#' @param header text to add before and after .x as header
#' @param options options to add before plotting function
#'
#' @returns
#' @export
#'
#' @examples
plot_tabset <- function(.x,
                        .pf,
                        header = c("## ", " {-}"),
                        options = "warning=FALSE") {
  map_chr(.x,
          \(x) {
            knitr::knit_child(text = c(
              paste0(header[1], x, header[2]),
              '',
              '```{r}',
              paste0('#|', options),
              str_replace_all(.pf, '__x__', x),
              '```',
              '',
              '\\',
              ''),
              envir = environment(), quiet = TRUE)}) %>%
    cat(sep = "\n")
}


