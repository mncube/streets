
<!-- README.md is generated from README.Rmd. Please edit that file -->

# streets

<!-- badges: start -->
<!-- badges: end -->

The goal of streets is to provide functions for working with paths
through 2D grids.

## Installation

You can install the development version of streets from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("mncube/streets")
```

## Load streets

``` r
library(streets)
```

## Manhattan Paths

On a 2D rectangular grid, all paths from the origin (0,0) to the
destination (i,j) have minimum Manhattan Distance if only upward and
rightward steps are allowed. The number of unique paths meeting this
condition (Manhattan Paths) can be computed in R as choose(i + j, j) or
as factorial(i+j)/(factorial(i)\*factorial(j)). Two example paths are
plotted below.

``` r
# Define the grid and paths
destination <- c(4, 4)
grid_size <- destination + 1
path1 <- rbind(c(0, 0), c(1, 0), c(1, 1), c(2, 1), c(3, 1), c(4, 1), c(4, 2), c(4, 3), c(4, 4))
path2 <- rbind(c(0, 0), c(0, 1), c(0, 2), c(0, 3), c(1, 3), c(2, 3), c(3, 3), c(3, 4), c(4, 4))

# Set up plot parameters
plot(NULL, xlim = c(0, 4), ylim = c(0, 4), xlab = "X", ylab = "Y", xaxs = "i", yaxs = "i", asp = 1)
abline(h = 0:4, v = 0:4, col = "lightgray", lty = 3)

# Plot the paths
lines(path1, col = "blue", lwd = 2)
lines(path2, col = "red", lwd = 2)
```

<img src="man/figures/README-ManhattanPathsPlot-1.png" width="100%" />

The mpaths function computes the number of unique Manhattan Paths from
the origin to the destination.

``` r
mpaths(destination = c(4,4))
#> [1] 70
```
