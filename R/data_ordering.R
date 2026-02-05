
#' Returns character label for various types of vecrtor elements
#'
#' @param x a vector
#'
#' @returns
#' @export
#'
#' @examples
classify_0NANaNInf <- function(x) {

  dplyr::case_when (is.null(x) ~ "NULL",
             is.nan(x) ~ "NaN",
             is.na(x) ~ "NA",
             is.character(x) ~ "abc",
             isTRUE(x) ~ "TRUE",
             isFALSE(x) ~ "FALSE",
             x == Inf ~ "Inf",
             x == Inf ~ "-Inf",
             x == 1 ~ "1",
             x == -1 ~ "-1",
             x == 0 ~ "0",
             x > 0 & x < 1 ~ "0-1",
             x < 0 & x > -1 ~ "-1-0",
             x > 1 ~ ">1",
             x < 1 ~ "<-1",
             .default = "something_else")

}


#' Transform values of x (row numbers) into groups of n
#'
#' @param x
#' @param n
#'
#' @returns
#' @export
#'
#' @examples
partition_n <- function(x, n) {

  if (!is.numeric(x)) x <- dplyr::dense_rank(x)

  ( (x - 1) %/% n ) + 1

}


#' Transforms id numbers into cahracters with equal number of leading zero's
#'
#' @param x
#' @param as.numeric
#'
#' @returns
#' @export
#'
#' @examples
num2idchar <- function(x, as.numeric = F) {

  if (as.numeric) x <- as.numeric(x)

  sprintf(paste0("%0", max(nchar(as.character(x))), "d"), x)

}


#' Transform values of x (row numbers) into groups of n as characters with equal
#' number of leading zero's
#'
#' @param x
#' @param n
#'
#' @returns
#' @export
#'
#' @examples
partition_n2char <- function(x, n) {

  num2idchar(partition_n(x, n))

}

