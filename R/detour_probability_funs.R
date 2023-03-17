#' Detour Paths Probability Mass Function
#'
#' A probability mass function where the number of detour paths through the
#' detour location specified in the detour parameter is the event of interest and
#' the sum of detour paths across all coordinates on the grid is the sample space.
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param detour A vector defining the detour location's coordinates in terms of
#' a horizontal coordinate ti and a vertical coordinate tj.
#'
#' @return A real number in the closed interval 0 to 1
#' @export
#'
#' @examples
#' ddpaths(c(2,2), c(2,1))
ddpaths <- function(destination = c(i, j),
                    detour = c(di, dj)){
  # Get values
  i <- destination[[1]]
  j <- destination[[2]]
  di <- detour[[1]]
  dj <- detour[[2]]

  # Count the sum of detour paths around each possible detour location on the
  #grid
  all_d_paths <- 0
  for (x in 0:i){
    for(y in 0:j){
      all_d_paths <- all_d_paths + dpaths(destination = destination,
                                          detour = c(x,y))
    }
  }

  # Compute the probability of the detour location
  dpaths(destination = destination,
         detour = detour)/all_d_paths
}


#' Detour Paths Cumulative Distribution Function
#'
#' A cumulative distribution function for the ddpaths probability mass function
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param detour A vector defining the detour coordinates in terms of a
#' horizontal coordinate ti and a vertical coordinate tj.
#'
#' @return A real number in the closed interval 0 to 1
#' @export
#'
#' @examples
#' pdpaths(destination = c(5,5), detour = c(1,1))
pdpaths <- function(destination = c(i, j), detour = c(di, dj)) {
  # Get values
  i <- destination[[1]]
  j <- destination[[2]]
  di <- detour[[1]]
  dj <- detour[[2]]

  # Initialize the cumulative probability
  cumulative_probability <- 0

  # Iterate through all possible detour coordinates up to and including (di, dj)
  for (x in 0:di) {
    for (y in 0:dj) {
      # Add the probability of each detour coordinate to the cumulative probability
      cumulative_probability <- cumulative_probability + ddpaths(destination = destination, detour = c(x, y))
    }
  }

  # Return the cumulative probability
  return(cumulative_probability)
}
