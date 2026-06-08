#' Title
#'
#' @param x
#' @param y
#'
#' @returns
#' @export
#'
#' @examples
#'
which_is <- function(x, y) {

  names(x)[x == y]

}

#' Title
#'
#' @param x
#' @param y
#'
#' @returns
#' @export
#'
#' @examples
#'
which_in <- function(x, y) {

  names(x)[x %in% y]

}


#' Count unique elements
#'
#' @param x
#'
#' @returns
#' @export
#'
#' @examples
length_unique <- \(x) {
  length(unique(x))
}


#' Count unique elemenmts with n >= 2
#'
#' @param x
#'
#' @returns
#' @export
#'
#' @examples
length_unique_min2 <- \(x) {
  length(unique(x[duplicated(x)]))
}


