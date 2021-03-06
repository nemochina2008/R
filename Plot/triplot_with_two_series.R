# Draw two series in the same triplot

rm(list = ls())
library(klaR)

# Create a table as such:
#
#             [,1]        [,2]      [,3]
#  [1,] 0.33333333 0.333333333 0.3333333
#  [2,] 0.25000000 0.125000000 0.6250000
#  [3,] 0.20000000 0.066666667 0.7333333
#  [4,] 0.16666667 0.041666667 0.7916667
#  [5,] 0.14285714 0.028571429 0.8285714
#  [6,] 0.12500000 0.020833333 0.8541667
#  [7,] 0.11111111 0.015873016 0.8730159
#  [8,] 0.10000000 0.012500000 0.8875000
#  [9,] 0.09090909 0.010101010 0.8989899
# [10,] 0.08333333 0.008333333 0.9083333

n <- 10
t <- matrix(0,n,3)
t
for (i in seq(1,n))
{
  x <- 1.0 / (i + 2)
	y <- 1.0 / ((i + 2) * i)
  z <- 1 - x - y
	t[i,1] <- x
	t[i,2] <- y
	t[i,3] <- z
}
t

u <- t
u[,1] <- t[,2]
u[,2] <- t[,3]
u[,3] <- t[,1]
u

# Plot the table
triplot(t,
	label=c("A","B","C"),
	grid = TRUE,
	t="l", #Draw lines between the data points
	col="red"
)
par(new=TRUE)
triplot(u,
	label=c("A","B","C"),
	grid = TRUE,
	t="l", #Draw lines between the data points
	col="blue"
)
