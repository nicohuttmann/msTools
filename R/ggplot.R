#' Title
#'
#' @param position
#' @param size
#' @param vjust
#' @param dodge
#'
#' @returns
#' @export
#'
#' @examples
add_n <- function(position = "max", size = 3, vjust = -0.6, dodge = 0.75) {

  if (position == "max")
    stat_summary(
      fun.data = \(y) data.frame(y = max(y), label = sum(!is.na(y))),
      geom = "text",
      position = position_dodge(width = dodge),
      vjust = vjust,
      size = size)
  else
    stat_summary(
      fun.data = \(y) data.frame(y = position, label = sum(!is.na(y))),
      geom = "text",
      position = position_dodge(width = dodge),
      vjust = vjust,
      size = size)
}


#' Title
#'
#' @param position
#' @param size
#' @param vjust
#' @param dodge
#'
#' @returns
#' @export
#'
#' @examples
add_y <- function(position = "y", size = 3, vjust = -0.6, dodge = 0.75) {

  if (position == "y")
    stat_summary(
      fun.data = \(y) data.frame(y = y, label = y),
      geom = "text",
      position = position_dodge(width = dodge),
      vjust = vjust,
      size = size)
  else
    stat_summary(
      fun.data = \(y) data.frame(y = position, label = y),
      geom = "text",
      position = position_dodge(width = dodge),
      vjust = vjust,
      size = size)
}


#' Title
#'
#' @param cutoff
#' @param position
#' @param size
#' @param vjust
#' @param dodge
#'
#' @returns
#' @export
#'
#' @examples
add_n_above <- function(cutoff = 0,
                        position = "max",
                        size = 3,
                        vjust = -0.6,
                        dodge = 0.75) {

  if (position == "max")
    stat_summary(
      fun.data = \(y) data.frame(y = max(y), label = sum(y > cutoff)),
      geom = "text",
      position = position_dodge(width = dodge),
      vjust = vjust,
      size = size)
  else
    stat_summary(
      fun.data = \(y) data.frame(y = position, label = sum(y > cutoff)),
      geom = "text",
      position = position_dodge(width = dodge),
      vjust = vjust,
      size = size)
}


#' Title
#'
#' @param cutoff
#' @param position
#' @param size
#' @param vjust
#' @param dodge
#'
#' @returns
#' @export
#'
#' @examples
add_n_below <- function(cutoff = 0,
                        position = "max",
                        size = 3,
                        vjust = -0.6,
                        dodge = 0.75) {

  if (position == "max")
    stat_summary(
      fun.data = \(y) data.frame(y = max(y), label = sum(y < cutoff)),
      geom = "text",
      position = position_dodge(width = dodge),
      vjust = vjust,
      size = size)
  else
    stat_summary(
      fun.data = \(y) data.frame(y = position, label = sum(y < cutoff)),
      geom = "text",
      position = position_dodge(width = dodge),
      vjust = vjust,
      size = size)
}


