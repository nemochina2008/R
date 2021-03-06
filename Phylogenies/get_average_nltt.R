source("~/GitHubs/R/Phylogenies/get_phylogeny_nltt_matrix.R")
source("~/GitHubs/R/Phylogenies/stretch_nltt_matrix.R")
source("~/GitHubs/R/MyFavoritePackages/TreeSim/R/LTT.general.R")
source("~/GitHubs/R/MyFavoritePackages/TreeSim/R/LTT.average.root.R")

library(ape)
library(geiger)
library(nLTT)
library(testit)

get_average_nltt <- function(
  phylogenies, 
  dt = 0.001,
  plot_nltts = FALSE,
  xlab = "Normalized Time", 
  ylab = "Normalized Lineages",
  replot = FALSE,
  ...
) {
  #  phylogenies, 
  #  dt: delta t, resolution of the averaged nLTT, where smaller is a higher resolution
  #  plot_nltts = FALSE,
  #  xlab: label on x axis
  #  ylab: label on y axis
  #  replot: if FALSE, a new plot is started, if TRUE, the lines is drawn over an assumed-to-be-present plot
  #  ...
  assert(dt > 0.0)
  assert(dt < 1.0)
  
  sz <- length(phylogenies)

  nltts <- NULL
  for (phylogeny in phylogenies) {
    nltts <- c(nltts,list(get_phylogeny_nltt_matrix(phylogeny)))
  }
  assert(length(nltts) == length(phylogenies))

  stretch_matrices <- NULL
  for (nltt in nltts) {
    stretch_matrix <- stretch_nltt_matrix(nltt,dt = dt)
    stretch_matrices <- c(stretch_matrices,list(stretch_matrix))
  }
  assert(length(stretch_matrices) == length(nltts))
  
  xy <- stretch_matrices[[1]]
  for (i in seq(2,sz)) {
    xy <- (xy + stretch_matrices[[i]])
  }
  xy <- (xy / sz)
  
  # Set the shape of the plot
  if (replot == FALSE) {
    plot.default(
      xy, 
      xlab = "Normalized Time", 
      ylab = "Normalized Lineages", 
      xaxs = "r", 
      yaxs = "r", 
      type = "S",
      xlim=c(0,1),
      ylim=c(0,1),
      ...
    )
  }
  
  # Draw the nLTTS plots used
  if (plot_nltts == TRUE) {
    for (stretch_matrix in stretch_matrices) {
      lines.default(
        stretch_matrix,
        xaxs = "r", 
        yaxs = "r", 
        type = "S",
        col="grey",
        xlim=c(0,1),
        ylim=c(0,1)
      )
    }
  }  

  # Redraw the average nLTT plot
  lines.default(
    xy,
    xaxs = "r", 
    yaxs = "r", 
    type = "S",
    xlim=c(0,1),
    ylim=c(0,1),
    ...
  )
}

get_average_nltt_new <- function(
  phylogenies, 
  dt = 0.001,
  plot_nltts = FALSE,
  xlab = "Normalized Time", 
  ylab = "Normalized Lineages",
  replot = FALSE,
  ...
) {
  #  phylogenies, 
  #  dt: delta t, resolution of the averaged nLTT, where smaller is a higher resolution
  #  plot_nltts = FALSE,
  #  xlab: label on x axis
  #  ylab: label on y axis
  #  replot: if FALSE, a new plot is started, if TRUE, the lines is drawn over an assumed-to-be-present plot
  #  ...
  assert(dt > 0.0)
  assert(dt < 1.0)
  
  sz <- length(phylogenies)
  
  
  nltts <- as.list(rep(NA, times = sz))
  assert(length(nltts) == length(phylogenies))
  for (i in seq(1,sz)) {
    nltts[i] <- list(get_phylogeny_nltt_matrix(phylogenies[[i]]))
  }
  assert(length(nltts) == length(phylogenies))

  stretch_matrices <- as.list(rep(NA, times = sz))
  assert(length(stretch_matrices) == length(nltts))
  for (i in seq(1,sz)) {
    stretch_matrices[[i]] <- list(stretch_nltt_matrix(nltts[i],dt = dt))
  }
  assert(length(stretch_matrices) == length(nltts))
  
  xy <- stretch_matrices[[1]]
  for (i in seq(2,sz)) {
    xy <- (xy + stretch_matrices[[i]])
  }
  xy <- (xy / sz)
  
  # Set the shape of the plot
  if (replot == FALSE) {
    plot.default(
      xy, 
      xlab = "Normalized Time", 
      ylab = "Normalized Lineages", 
      xaxs = "r", 
      yaxs = "r", 
      type = "S",
      xlim=c(0,1),
      ylim=c(0,1),
      ...
    )
  }
  
  # Draw the nLTTS plots used
  if (plot_nltts == TRUE) {
    for (stretch_matrix in stretch_matrices) {
      lines.default(
        stretch_matrix,
        xaxs = "r", 
        yaxs = "r", 
        type = "S",
        col="grey",
        xlim=c(0,1),
        ylim=c(0,1)
      )
    }
  }  

  # Redraw the average nLTT plot
  lines.default(
    xy,
    xaxs = "r", 
    yaxs = "r", 
    type = "S",
    xlim=c(0,1),
    ylim=c(0,1),
    ...
  )
}


get_average_nltt_new_abandon <- function(
  phylogenies, 
  plot_nltts = FALSE,
  xlab = "Normalized Time", 
  ylab = "Normalized Lineages",
  replot = FALSE,
  ...
) {
  #  phylogenies, 
  #  dt: delta t, resolution of the averaged nLTT, where smaller is a higher resolution
  #  plot_nltts = FALSE,
  #  xlab: label on x axis
  #  ylab: label on y axis
  #  replot: if FALSE, a new plot is started, if TRUE, the lines is drawn over an assumed-to-be-present plot
  #  ...
  for (i in seq(1,length(phylogenies)))
  {
    t <- ltt.plot.coords(phylogenies[[i]])
    #t
    crown_age <- -t[1,1]
    crown_age
    t[,1] <- (t[,1] / crown_age) + 1
    #t
    n_lineages <- t[nrow(t),2]
    t[,2] <- t[,2] / n_lineages
    #t
    if (i == 1) {
      plot(t, type='l',col='gray',xlab="time",ylab="number of species")
    } else {
      lines(t, type='l',col='gray')
    }
  }
  lines(
    LTT.average.root(phylogenies) + 1, col='black'
  )
#   plot(
#     LTT.average.root(phylogenies) + 1,
#     type='l',col='black',xlab="time",ylab="number of species"
#   )
  
  # Set the shape of the plot
  if (replot == FALSE) {
    plot(
      LTT.average.root(phylogenies),
      type='l',
      col='black',
      xlab = "Normalized Time", 
      ylab = "Normalized Lineages"
    )
  }

  # Draw the nLTTS plots used
  if (plot_nltts == TRUE) {
    for (phylogeny in phylogenies)
    {
      nLTT.lines(phylogeny)
    }
  }  
  
  # Redraw the average nLTT plot
  lines.default(
    LTT.average.root(phylogenies),
    type='l',
    col='black'
  )
}