#' Branch Paths Probability Mass Function
#'
#' A probability mass function where the number of branch paths through the
#' branch location specified in the branch parameter is the event of interest and
#' the sum of branch paths across all coordinates on the grid is the sample space.
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param branch A vector defining the branch location's coordinates in terms of
#' a horizontal coordinate bi and a vertical coordinate bj.
#'
#' @return A real number in the closed interval 0 to 1
#' @export
#'
#' @examples
#' dbpaths(c(2,2), c(2,1))
dbpaths <- function(destination = c(i, j),
                    branch = c(bi, bj)){
  # Get values
  i <- destination[[1]]
  j <- destination[[2]]
  bi <- branch[[1]]
  bj <- branch[[2]]

  # Count the sum of branch paths through each possible branch location on the
  #grid
  all_b_paths <- 0
  for (x in 0:i){
    for(y in 0:j){
      all_b_paths <- all_b_paths + bpaths(destination = destination,
                                          branch = c(x,y))
    }
  }

  # Compute the probability of the target location
  bpaths(destination = destination,
         branch = branch)/all_b_paths
}


#' Branch Paths Cumulative Distribution Function
#'
#' A cumulative distribution function for the dbpaths probability mass function
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param branch A vector defining the branch coordinates in terms of a
#' horizontal coordinate bi and a vertical coordinate bj.
#'
#' @return A real number in the closed interval 0 to 1
#' @export
#'
#' @examples
#' pbpaths(destination = c(5,5), branch = c(1,1))
pbpaths <- function(destination = c(i, j), branch = c(bi, bj)) {
  # Get values
  i <- destination[[1]]
  j <- destination[[2]]
  bi <- branch[[1]]
  bj <- branch[[2]]

  # Initialize the cumulative probability
  cumulative_probability <- 0

  # Iterate through all possible branch coordinates up to and including (bi, bj)
  for (x in 0:bi) {
    for (y in 0:bj) {
      # Add the probability of each branch coordinate to the cumulative probability
      cumulative_probability <- cumulative_probability +
        dbpaths(destination = destination, branch = c(x, y))
    }
  }

  # Return the cumulative probability
  return(cumulative_probability)
}
