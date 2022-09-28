# constants and updates to make plots look like "Truveta"

manufacturer_color_palette <- 
  c(Pfizer = "#0190FF", Moderna = "#EA4024", Janssen = "#194687")

color_palette <- c(
  "#999999",
  "#E69F00",
  "#56B4E9",
  "#009E73",
  "#F0E442",
  "#0072B2",
  "#D55E00",
  "#CC79A7"
)

# first attempt on Truveta Theme
default_color <- "#2BB1A7"

ggplot2::update_geom_defaults("line", list(size = 1.2, color = default_color))
ggplot2::update_geom_defaults("bar", list(fill = default_color))
ggplot2::update_geom_defaults("col", list(fill = default_color))
ggplot2::update_geom_defaults("point", list(fill = default_color))

theme_truveta <- function() {
  ggplot2::theme_minimal() +
    ggplot2::theme(
      legend.position = "top", legend.justification = "left",
      legend.title = ggplot2::element_blank(),
      text = ggplot2::element_text(size = 12),
      plot.title = ggplot2::element_text(
        size = 16, 
        colour = "#5068DA", 
        hjust = 0
      ),
      axis.title.x = ggplot2::element_text(hjust = 1)
    )
}



#' Make summary histogram
#'
#' Given data, and what columns to plot, make a histogram with title.
#'
#' @param data data frame
#' @param dim x axis value (column in data) tidyeval bare
#' @param n y axis value (column in data) tidyeval bare
#' @param title string with title for graph
#' @return object of class ggplot
#' @export
make_hist_plot <- function(data, dim, n, title) {
  viz <-
    ggplot2::ggplot(
      data,
      ggplot2::aes(
        x = !!rlang::sym(dim),
        y = !!rlang::sym(n)
      )
    ) +
    ggplot2::geom_col() +
    ggplot2::labs(y = "Count", title = title) +
    theme_truveta()

  viz
}



#' Make sample size funnel plot
#'
#' Journals like a pretty picture of how sample size changes with exclusion
#' criteria. This fulfills that shibboleth.
#'
#' @param funnel data frame
#' @return plotly graph
#' @export
make_funnel_plot <- function(funnel) {
  fig <- plotly::plot_ly(
    type = "funnel",
    x = funnel$size,
    y = funnel$step,
    textposition = "inside",
    textinfo = "value+percent initial"
  )
  # enforce right order
  fig <-
    fig %>%
    plotly::layout(
      yaxis = list(categoryorder = "array", categoryarray = funnel$step)
    )

  fig
}
