# just a few to start with
packs <-
  c(
    "tidyverse", # big bundle of packages
    "tidymodels", # broom plus other things some people like
    "dplyr",
    "dtplyr",
    "ggplot2",
    "patchwork",
    "table1",
    "tidyr",
    "readr",
    "purrr",
    "tibble",
    "stringr",
    "forcats",
    "lubridate",
    "magrittr",
    "tidyselect",
    "rlang",
    "broom",
    "bit64",
    "scales", # axis transforms and plot improvers
    "janitor", # clean_names
    "here", # relative pathing
    "arrow", # parquet
    "future", # good parallel library
    "future.callr", # callr with future
    "targets", # workflow manager
    "tarchetypes",
    "svglite", # plotting
    "plotly", # plotting
    "gt", # tables
    "digest", # hash codes
    "bibtex", # bibliographies,
    "reticulate" # python binding
  )

install.packages(
  packs,
  repos = "https://cloud.r-project.org/"
)
