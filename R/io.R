#' Save a csv table to disc and return path
#'
#' Saves file to `results` directory with file as name.
#'
#' @param df data frame or tibbe
#' @param filepath name of file with correct file type (e.g. csv)
#' @return path of saved file (also file written disc)
#' @export
write_table <- function(df, filepath, ...) {
  stopifnot(is.character(filepath), length(filepath) == 1)
  readr::write_csv(df, file = filepath, row.names = FALSE, ...)
  return(filepath)
}

#' Save a parquet table to disc and return path
#'
#' Saves file to `results` directory with file as name.
#'
#' @param df data frame or tibbe
#' @param filepath name of file with correct file type (e.g. parquet)
#' @return path of saved file (also file written disc)
#' @export
write_parquet_table <- function(df, filepath, ...) {
  stopifnot(is.character(filepath), length(filepath) == 1)
  arrow::write_parquet(x = df, sink = filepath, ...)
  return(filepath)
}


#' Read a csv file from disc
#'
#' given file path, read.csv
#'
#' @param filename path to .csv file
#' @return a data frame
#' @export
read_table <- function(filename, ...) {
  stopifnot(is.character(filename), length(filename) == 1)
  data <- readr::read_csv(filename, show_col_types = FALSE, comment = "#", ...)
  return(data)
}

#' Read a parquet file from disc
#'
#' given file path, read.csv
#'
#' @param filename path to .csv file
#' @return a data frame
#' @export
read_parquet_table <- function(filename, ...) {
  stopifnot(is.character(filename), length(filename) == 1)
  data <- arrow::read_parquet(filename, ...)
  return(data)
}

#' Read a JSON file from disc
#'
#' given file path, read.csv
#'
#' @param filename path to .csv file
#' @return a data frame
#' @export
read_json_file <- function(filename, ...) {
  stopifnot(is.character(filename), length(filename) == 1)
  data <- jsonlite::read_json(filename, ...)
  return(data)
}


#' Write gt table to disc as html, rtf, and tex (start with html!)
#'
#' @param x object of class gt_tbl
#' @param filename where to write file (either .html or .rtf)
#' @param ... other arguments for `gt::gtsave`
#' @return path of saved file (also 2 plots to disc)
#' @export
write_gt <- function(x, filename, ...) {
  stopifnot(inherits(x, "gt_tbl"))
  stopifnot(is.character(filename), length(filename) == 1)

  gt::gtsave(x, filename, ...)

  # generate RTF version, too
  rtf_filename <- stringr::str_replace(filename, ".html", ".rtf")
  if (!stringr::str_ends(rtf_filename, ".rtf")) {
    rtf_filename <- paste0(rtf_filename, ".rtf")
  }
  gt::gtsave(x, rtf_filename, ...)

  # generate RTF version, too
  tex_filename <- stringr::str_replace(filename, ".html", ".tex")
  if (!stringr::str_ends(tex_filename, ".tex")) {
    tex_filename <- paste0(tex_filename, ".tex")
  }
  gt::gtsave(x, tex_filename, ...)

  return(filename)
}



#' Write ggplot figure to disc (png and svg)
#'
#' given plot and filename...
#'
#' @param x object of class ggplot2
#' @param filename path to where file is to be written
#' @param ... additional arguments for ggsave
#' @return path of saved file (also two files to disc)
#' @export
write_ggplot <- function(x, filename, ...) {
  stopifnot(inherits(x, "ggplot"))
  stopifnot(is.character(filename), length(filename) == 1)

  ggplot2::ggsave(filename = filename, plot = x, ...)

  # generate SVG file, too
  svg_filename <- stringr::str_replace(filename, ".png", ".svg")
  if (!stringr::str_ends(svg_filename, ".svg")) {
    svg_filename <- paste0(svg_filename, ".svg")
  }
  ggplot2::ggsave(filename = svg_filename, plot = x, ...)

  return(filename)
}




#' Write plotly figure to disc (png and svg)
#'
#' given plot and filename...
#'
#' note: many Python dependencies!
#'
#' @param x object of class plotly
#' @param filename path to where file is to be written
#' @param ... additional arguments for `plotly::save_image`
#' @return path of saved file (also two files to disc)
#' @export
write_plotly <- function(x, filename, ...) {
  stopifnot(is.character(filename), length(filename) == 1)

  plotly::save_image(p = x, file = filename, ...)
  # generate SVG file, too
  svg_filename <- stringr::str_replace(filename, ".png", ".svg")
  if (!stringr::str_ends(svg_filename, ".svg")) {
    svg_filename <- paste0(svg_filename, ".svg")
  }
  plotly::save_image(p = x, file = svg_filename, ...)

  return(filename)
}
