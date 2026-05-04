#' Title
#'
#' @param ... additional parameters for pdf()
#' @param width the width of the graphics region in inches (default = 5)
#' @param height the height of the graphics region in inches (default = 5)
#'
#' @returns
#' @export
#'
#' @examples
#' pdf_temp()
#' plot(6, 9)
#' pdf_open
pdf_temp <- function(width = 5, height = 5, ...) {
  file <- tempfile(fileext = ".pdf")
  .pdf_temp <<- file
  pdf(file = file, width = width, height = height, ...)
  return(invisible(file))
}


#' Title
#'
#' @param ... additional parameters for pdf()
#' @param width the width of the graphics region in inches (default = 5)
#' @param height the height of the graphics region in inches (default = 5)
#'
#' @returns
#' @export
#'
#' @examples
#' pdf_temp()
#' plot(6, 9)
#' pdf_open
pdf_perm <- function(file, width = 5, height = 5, dir, ...) {

  if (!hasArg(file)) stop("You must provide a file name for pdf_perm().")

  # Get final file path
  if (hasArg(dir)) file_dir <- file.path(dir, file)
  else file_dir <- file

  if (!stringr::str_detect(tolower(file_dir), "\\.pdf$"))
    file_dir <- paste0(file_dir, ".pdf")

  .pdf_temp <<- file_dir
  pdf(file = file_dir, width = width, height = height, ...)
  return(invisible(file_dir))
}


#' Title
#'
#' @param file pdf file to open (opens file saved under .pdf_temp if no argument given)
#'
#' @returns
#' @export
#'
#' @examples
#' pdf_temp()
#' plot(6, 9)
#' pdf_open
pdf_open <- function(file) {

  while (length(dev.list()!=0)) dev.off()

  if (!hasArg(file) && !exists(".pdf_temp")) {
    message("Nothing to open.")
    return(invisible(F))
  } else if (hasArg(file)) {
    system(paste0('open "', file, '"'))
    return(invisible(T))
  } else {
    system(paste0('open "', .pdf_temp, '"'))
    return(invisible(T))
  }
}


#' Title
#'
#' @param ... additional parameters for png()
#' @param width the width of the graphics region in the given unit
#' (default = 10)
#' @param height the height of the graphics region in the given unit
#' (default = 5)
#' @param units The units in which height and width are given. Can be cm
#' (default), mm, px (pixels) or in (inches)
#' @param res the resolution in ppi
#'
#' @returns
#' @export
#'
#' @examples
#' png_temp()
#' plot(6, 9)
#' png_open
png_temp <- function(..., width = 10, height = 5, units = "cm", res = 300) {
  file <- tempfile(fileext = ".png")
  .png_temp <<- file
  png(file = file,
      width = width,
      height = height,
      units = units,
      res = res,
      ...)
  return(invisible(file))
}

#' Title
#'
#' @param file png file to open (opens file saved under .png_temp if no argument given)
#'
#' @returns
#' @export
#'
#' @examples
#' png_temp()
#' plot(6, 9)
#' png_open
png_open <- function(file) {

  while (length(dev.list()!=0)) dev.off()

  if (!hasArg(file) && !exists(".png_temp")) {
    message("Nothing to open.")
    return(invisible(F))
  } else if (hasArg(file)) {
    system(paste0('open "', file, '"'))
    return(invisible(T))
  } else {
    system(paste0('open "', .png_temp, '"'))
    return(invisible(T))
  }
}



#' Title
#'
#' @param ... additional parameters for tiff()
#' @param width the width of the graphics region in the given unit (default = 10)
#' @param height the height of the graphics region in the given unit (default = 5)
#' @param units The units in which height and width are given. Can be cm
#' (default), mm, px (pixels) or in (inches)
#' @param res the resolution in ppi
#'
#' @returns
#' @export
#'
#' @examples
#' tiff_temp()
#' plot(6, 9)
#' tiff_open
tiff_temp <- function(..., width = 10, height = 5, units = "cm", res = 300) {
  file <- tempfile(fileext = ".tiff")
  .tiff_temp <<- file
  tiff(file = file,
       width = width,
       height = height,
       units = units,
       res = res,
       ...)
  return(invisible(file))
}

#' Title
#'
#' @param file tiff file to open (opens file saved under .tiff_temp if no argument given)
#'
#' @returns
#' @export
#'
#' @examples
#' tiff_temp()
#' plot(6, 9)
#' tiff_open
tiff_open <- function(file) {

  while (length(dev.list()!=0)) dev.off()

  if (!hasArg(file) && !exists(".tiff_temp")) {
    message("Nothing to open.")
    return(invisible(F))
  } else if (hasArg(file)) {
    system(paste0('open "', file, '"'))
    return(invisible(T))
  } else {
    system(paste0('open "', .tiff_temp, '"'))
    return(invisible(T))
  }
}


#' Plots text on an empty ggplots
#'
#' @param text text to display
#' @param size text size
#'
#' @returns
#' @export
#'
#' @examples
plot_ggtext <- function(text = "Lorem ipsum whatever", size = 8) {
  ggplot2::ggplot() +
    ggplot2::theme_void() +
    ggplot2::annotate("text", x = 0, y = 0,
                      label = text, size = size)
}
