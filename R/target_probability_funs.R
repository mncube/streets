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
