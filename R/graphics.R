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


.file_dir_ext <- function(file, dir, fileext = "") {

  # Combine or generate file name and directory
  if (!hasArg(file) || is.null(file)) {
    if (!hasArg(dir) || is.null(dir)) dir <- tempdir()
    file_dir <- tempfile(tmpdir = dir, fileext = fileext)
  } else {
    if (hasArg(dir)) file_dir <- file.path(dir, file)
    else file_dir <- file
  }

  # Check file extension
  if (!stringr::str_detect(tolower(file_dir), paste0("\\.", fileext, "$")) && fileext != "")
    file_dir <- paste0(file_dir, paste0(".", fileext))

  return(file_dir)
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
#' @param title
#' @param width
#' @param height
#' @param expr
#' @param file
#' @param dir
#' @param open
#' @param ...
#'
#' @returns
#' @export
#'
#' @examples
pdf_ <- function(expr, title, width = 8, height = 5, file, dir, open = T, ...) {

  file <- .file_dir_ext(file, dir, "pdf")
  pdf(file = file,
      width = width,
      height = height,
      ...)

  if (!open) on.exit(dev.off())

  expr <- substitute(expr)

  # Split block into individual expressions, eval each with auto-print
  exprs <- if (is.call(expr) && expr[[1]] == as.name("{")) {
    as.list(expr)[-1]   # strip the `{`, get each statement
  } else {
    list(expr)
  }

  # add title
  if (hasArg(title)) {
    print(plot_ggtext(title))
  }

  for (e in exprs) {
    tryCatch({
      res <- withVisible(eval(e, envir = parent.frame()))
      if (res$visible) print(res$value)
    },
    error = function(error) {
      print(plot_ggtext(paste(error,
                              paste(as.character(e),
                                    collapse = "") %>%
                                str_replace_all("%>%", "%>%\n") %>%
                                str_replace_all("\\+", "\\+\n"),
                              sep = "\n"),
                        size = 5))
    })
  }

  if (open) pdf_open(file)

  return(invisible(file))
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
