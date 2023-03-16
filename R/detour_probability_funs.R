#' Detour Location Probability Mass Function
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
