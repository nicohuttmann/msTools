#' Vector with elements as names
#'
#' @param ... vector/s whose elements become their own names
#'
#' @returns a character vector named by its own elements
#' @export
#'
#'
cc <- function(...) {
  setNames(c(...), c(...))
}


#' F(actors) U(nique)
#'
#' @param x a vector
#'
#' @return
#' @export
#'
#'
fu <- function (x) {
  factor(x = x, levels = unique(x))
}


#' F(actors) U(nique) S(orted)
#'
#' @param x a vector
#' @param decreasing sort in decreasing order (default=F)
#'
#' @return
#' @export
#'
#'
fus <- function (x, decreasing = F) {
  factor(x = x, levels = sort(unique(x), decreasing = decreasing))
}



#' Removes objects from the global environment
#'
#' Everything in the global environment is removed except the dataset registry
#' (`Analysis`, `Datasets`, `Info`) and anything named in <exclude>, so a long
#' session can be cleared without losing the attached datasets.
#'
#' @param exclude names of further objects to keep
#'
#' @returns "Good job." (invisibly)
#' @export
#'
#' @examples
#'   x <- 1
#'   cleanup(exclude = "x")
cleanup <- function(exclude = c()) {
  
  rm(list = setdiff(objects(name = globalenv()), c("Analysis", 
                                                   "Datasets", 
                                                   "Info", 
                                                   exclude)), 
     pos = globalenv())
  
  return(invisible("Good job."))
  
}
