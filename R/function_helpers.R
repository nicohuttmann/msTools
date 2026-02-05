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

