#' Title
#'
#' @param position where to place the label ("max", "min" or "mean")
#' @param size text size of the label
#' @param vjust vertical justification of the label
#' @param dodge width passed to `position_dodge()`, to match a dodged geom
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


#' Add y-vlaues to a ggplot
#'
#' @param position where to place the label ("max", "min" or "mean")
#' @param size text size of the label
#' @param vjust vertical justification of the label
#' @param dodge width passed to `position_dodge()`, to match a dodged geom
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
#' @param cutoff value below/above which the label is placed
#' @param position where to place the label ("max", "min" or "mean")
#' @param size text size of the label
#' @param vjust vertical justification of the label
#' @param dodge width passed to `position_dodge()`, to match a dodged geom
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
#' @param cutoff value below/above which the label is placed
#' @param position where to place the label ("max", "min" or "mean")
#' @param size text size of the label
#' @param vjust vertical justification of the label
#' @param dodge width passed to `position_dodge()`, to match a dodged geom
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


#' Helps make nice axis limit breaks
#'
#' @param plot.limits vector containing plot limits
#' @param break.size space between breaks
#'
#' @returns list with elements `limits` and `breaks`
#' @export
#'
.axis_limit_breaks <- function(plot.limits, break.size = NULL) {

  output <- list()

  # find break size automatically (target = 5 breaks)
  if (is.null(break.size)) {
    opt_break_size <- c(50, 20, 10, 5, 2, 1, 0.5, 0.2, 0.1)
    limit_range <- plot.limits[2] - plot.limits[1]

    mag <- round(log10(limit_range)) - 1
    n_breaks <- limit_range / (opt_break_size * 10^mag)
    opt_break_size <- opt_break_size[n_breaks >= 3]
    n_breaks <- n_breaks[n_breaks >= 3]

    best_break <- which(c(min(abs(4 - n_breaks)) == abs(4 - n_breaks)))[1]
    break.size <- opt_break_size[best_break] * 10^mag
  }

  output[["limits"]] <- c(floor(plot.limits[1] / break.size) * break.size,
                          ceiling(plot.limits[2] / break.size) * break.size)

  output[["breaks"]] <- seq(output[["limits"]][1],
                            output[["limits"]][2],
                            break.size)

  # Return
  return(output)

}


#' Extract the built x/y axis ranges of a ggplot
#'
#' @param plot a ggplot object
#'
#' @returns list with `xmin`, `xmax`, `ymin`, `ymax`
#' @export
#'
.get_plot_limits <- function(plot) {
  gb <- ggplot2::ggplot_build(plot)
  xmin <- gb$layout$panel_params[[1]]$x.range[1]
  xmax <- gb$layout$panel_params[[1]]$x.range[2]
  ymin <- gb$layout$panel_params[[1]]$y.range[1]
  ymax <- gb$layout$panel_params[[1]]$y.range[2]
  list(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax)
}


#' Defines ggplot panel by ratio, size, unit size, center, and axis breaks (`+`-able)
#'
#' Add to a ggplot with `+`, e.g. `p + set_continuous_axes(axis.unit.ratio = 1)`.
#' Reads the built plot limits, so add it last in the chain.
#'
#' @param x.axis.limits vector containing lower and upper x-axis limits
#' @param y.axis.limits vector containing lower and upper y-axis limits
#' @param x.axis.breaks distance between x-axis breaks
#' @param y.axis.breaks distance between y-axis breaks
#' @param aspect.ratio absolute length of x-axis/y-axis
#' @param plot.center vector for center of plot
#' @param axis.unit.ratio ratio between x- and y-axis units
#' @param coord_fun coord function to apply the unit ratio with
#' @param expand.x.axis expand x.axis (see scale_x_continuous)
#' @param expand.y.axis expand y.axis (see scale_y_continuous)
#'
#' @returns an object to be added to a ggplot with `+`
#' @export
#'
set_continuous_axes <- function(x.axis.limits = NULL,
                                y.axis.limits = NULL,
                                x.axis.breaks = NULL,
                                y.axis.breaks = NULL,
                                aspect.ratio = 1,
                                plot.center = NULL,
                                axis.unit.ratio = NULL,
                                coord_fun = coord_fixed,
                                expand.x.axis = c(0, 0),
                                expand.y.axis = c(0, 0)) {

  structure(
    list(x.axis.limits   = x.axis.limits,
         y.axis.limits   = y.axis.limits,
         x.axis.breaks   = x.axis.breaks,
         y.axis.breaks   = y.axis.breaks,
         aspect.ratio    = aspect.ratio,
         plot.center     = plot.center,
         axis.unit.ratio = axis.unit.ratio,
         coord_fun       = coord_fun,
         expand.x.axis   = expand.x.axis,
         expand.y.axis   = expand.y.axis),
    class = "set_continuous_axes"
  )
}


#' @export
#' @method ggplot_add set_continuous_axes
#' @importFrom ggplot2 ggplot_add
ggplot_add.set_continuous_axes <- function(object, plot, ...) {

  # Unpack stored arguments
  x.axis.limits   <- object$x.axis.limits
  y.axis.limits   <- object$y.axis.limits
  x.axis.breaks   <- object$x.axis.breaks
  y.axis.breaks   <- object$y.axis.breaks
  aspect.ratio    <- object$aspect.ratio
  plot.center     <- object$plot.center
  axis.unit.ratio <- object$axis.unit.ratio
  coord_fun       <- object$coord_fun
  expand.x.axis   <- object$expand.x.axis
  expand.y.axis   <- object$expand.y.axis

  p <- plot

  plot_limits0 <- .get_plot_limits(p)
  plot_limits  <- plot_limits0


  # Given plot center
  if (!is.null(plot.center)) {

    x <- max(abs(unlist(plot_limits0[1:2]) - plot.center[1]))

    plot_limits[["xmin"]] <- - x + plot.center[1]
    plot_limits[["xmax"]] <- + x + plot.center[1]

    y <- max(abs(unlist(plot_limits0[3:4]) - plot.center[2]))

    plot_limits[["ymin"]] <- - y + plot.center[2]
    plot_limits[["ymax"]] <- + y + plot.center[2]

  } else {

    plot.center <- c(mean(unlist(plot_limits[1:2])),
                     mean(unlist(plot_limits[3:4])))

  }


  # Given limits
  if (!is.null(x.axis.limits) & !is.null(y.axis.limits)) {

    if (length(x.axis.limits) != 2 | length(y.axis.limits) != 2)
      stop("x.axis.limits and y.axis.limits must be a numeric vector of length 2 like c(-1, 1).")

    plot_limits[["xmin"]] <- x.axis.limits[1]
    plot_limits[["xmax"]] <- x.axis.limits[2]
    plot_limits[["ymin"]] <- y.axis.limits[1]
    plot_limits[["ymax"]] <- y.axis.limits[2]

    p <- p +
      theme(aspect.ratio = aspect.ratio) +
      scale_x_continuous(limits = unlist(plot_limits[1:2]),
                         breaks = .axis_limit_breaks(plot.limits = unlist(plot_limits[1:2]),
                                                     break.size = x.axis.breaks)$breaks,
                         expand = expand.y.axis) +
      scale_y_continuous(limits = unlist(plot_limits[3:4]),
                         breaks = .axis_limit_breaks(plot.limits = unlist(plot_limits[3:4]),
                                                     break.size = y.axis.breaks)$breaks,
                         expand = expand.y.axis)
    if (any(str_detect(deparse(args(coord_fun)), "ratio")))
      p <- p + coord_fun(ratio = axis.unit.ratio)

  # Given axis.unit.ratio
  } else if (!is.null(axis.unit.ratio)) {

    x <- plot_limits[["xmax"]] - plot.center[1]
    y <- (plot_limits[["ymax"]] - plot.center[2]) * axis.unit.ratio

    if (x > y) {

      plot_limits[["ymin"]] <- plot_limits[["ymin"]] - (x - y) / axis.unit.ratio
      plot_limits[["ymax"]] <- plot_limits[["ymax"]] + (x - y) / axis.unit.ratio

    } else if (x < y) {

      plot_limits[["xmin"]] <- plot_limits[["xmin"]] - (y - x)
      plot_limits[["xmax"]] <- plot_limits[["xmax"]] + (y - x)

    }

    p <- p +
      theme(aspect.ratio = aspect.ratio) +
      scale_x_continuous(limits = unlist(plot_limits[1:2]),
                         breaks = .axis_limit_breaks(plot.limits = unlist(plot_limits[1:2]),
                                                     break.size = x.axis.breaks)$breaks,
                         expand = expand.y.axis) +
      scale_y_continuous(limits = unlist(plot_limits[3:4]),
                         breaks = .axis_limit_breaks(plot.limits = unlist(plot_limits[3:4]),
                                                     break.size = y.axis.breaks)$breaks,
                         expand = expand.y.axis)
    if (any(str_detect(deparse(args(coord_fun)), "ratio")))
      p <- p + coord_fun(ratio = axis.unit.ratio)

  } else {

    p <- p +
      theme(aspect.ratio = aspect.ratio) +
      scale_x_continuous(limits = unlist(plot_limits[1:2]),
                         breaks = .axis_limit_breaks(plot.limits = unlist(plot_limits[1:2]),
                                                     break.size = x.axis.breaks)$breaks,
                         expand = expand.y.axis) +
      scale_y_continuous(limits = unlist(plot_limits[3:4]),
                         breaks = .axis_limit_breaks(plot.limits = unlist(plot_limits[3:4]),
                                                     break.size = y.axis.breaks)$breaks,
                         expand = expand.y.axis)
  }

  # Return the modified plot (ggplot_add must return the plot)
  p
}


#' Add PCA axis labels (with % variance) to a ggplot (`+`-able)
#'
#' Add to a ggplot with `+`, e.g. `p + set_PCA_labs()`.
#'
#' @param PCx,PCy principal component numbers; inferred from the plot mapping if omitted
#' @param sdev vector of PC standard deviations; computed from the plot data if omitted
#' @param digits digits for the rounded percentage
#'
#' @returns an object to be added to a ggplot with `+`
#' @export
#'
set_PCA_labs <- function(PCx = NULL, PCy = NULL, sdev = NULL, digits = 1) {

  structure(
    list(PCx = PCx, PCy = PCy, sdev = sdev, digits = digits),
    class = "set_PCA_labs"
  )
}


#' @export
#' @method ggplot_add set_PCA_labs
#' @importFrom ggplot2 ggplot_add
ggplot_add.set_PCA_labs <- function(object, plot, ...) {

  p      <- plot
  PCx    <- object$PCx
  PCy    <- object$PCy
  sdev   <- object$sdev
  digits <- object$digits

  if (is.null(sdev)) {
    sdev <- p[["data"]] %>%
      select(starts_with("PC")) %>%
      summarise(across(everything(), sd)) %>%
      c() %>%
      unlist()
  }

  if (is.null(PCx)) PCx <- match(all.vars(p[["mapping"]][["x"]]), names(sdev))

  if (is.null(PCy)) PCy <- match(all.vars(p[["mapping"]][["y"]]), names(sdev))


  # Add variances
  p <- p + xlab(
    paste0(
      "PC", PCx, " (",
      round(
        with(
          list(x = sdev),
          x^2 / sum(x^2))[PCx] * 100, digits), "%)")) +
    ylab(
      paste0(
        "PC", PCy, " (",
        round(
          with(list(x = sdev),
               x^2 / sum(x^2))[PCy] * 100, digits), "%)"))

  # Return the modified plot
  p
}


