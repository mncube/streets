#' Target Location Probability Mass Function
#'
#' A probability mass function where the number of Target Paths (with a target
#' location defined with the targer parameter) is the event of interest and the
#' number of Manhattan Paths (on a grid defined with the destination parameter)
#' is the sample space.
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param target A vector defining the target coordinates in terms of a
#' horizontal coordinate ti and a vertical coordinate tj.
#'
#' @return A real number in the closed interval 0 to 1
#' @export
#'
#' @examples
#' ptpaths(destination = c(5,5), target = c(1,1))
ptpaths <- function(destination = c(i, j),
                   target = c(ti, tj)){
  #Get values
  i <- destination[[1]]
  j <- destination[[2]]
  ti <- target[[1]]
  tj <- target[[2]]

  tpaths(destination = destination,
         target = target)/mpaths(destination = destination)
}


#' Target Location Probability Mass Function
#'
#' A probability mass function where the number of target paths through the
#' target location specified in the target parameter is the event of interest and
#' the sum of target paths across all coordinates on the grid is the sample space.
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param target A vector defining the target location's coordinates in terms of
#' a horizontal coordinate ti and a vertical coordinate tj.
#'
#' @return A real number in the closed interval 0 to 1
#' @export
#'
#' @examples
#' dtpaths(c(2,2), c(2,1))
dtpaths <- function(destination = c(i, j),
                    target = c(ti, tj)){
  # Get values
  i <- destination[[1]]
  j <- destination[[2]]
  ti <- target[[1]]
  tj <- target[[2]]

  # Count the sum of target paths through each possible target location on the
  #grid
  all_t_paths <- 0
  for (x in 0:i){
    for(y in 0:j){
      all_t_paths <- all_t_paths + tpaths(destination = destination,
                                          target = c(x,y))
    }
  }

  # Compute the probability of the target location
  tpaths(destination = destination,
         target = target)/all_t_paths


}
