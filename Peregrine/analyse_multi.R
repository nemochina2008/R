source("~/GitHubs/R/Peregrine/plot_multi_average_nltts.R")
source("~/GitHubs/R/Peregrine/plot_multi_nltt_stats_histogram.R")

analyse_multi <- function(filenames) {
  plot_multi_average_nltts(filenames)
  plot_multi_nltt_stats_histogram(filenames)
}