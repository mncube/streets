#' Target Paths
#'
#' The tpaths function computes the number of paths with equal Manhattan Distance
#' starting at the origin (0,0) passing through the target coordinate (ti, tj) and
#' ending at the destination (i, j).
#'
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j
#'
#' @param target A vector defining the target coordinates in terms of a horizontal
#' coordinate ti and a vertical coordinate tj
#'
#' @return A number
#' @export
#'
#' @examples
#' tpaths(destination = c(4,4), target = c(2,2))
tpaths <- function(destination = c(i,j), target = c(ti, tj)){

  #Get values
  i <- destination[[1]]
  j <- destination[[2]]
  ti <- target[[1]]
  tj <- target[[2]]

  if (ti > i | tj > j){
    rlang::abort(message = "Target coordinate must be on grid.  Make sure i >= ti and
                 j >= tj.")
  }

  if (ti < 0 | tj < 0){
    rlang::abort(message = "ti and tj must be non-negative.")
  }

  if (ti != floor(ti) | tj != floor(tj)){
    rlang::abort(message = "ti and tj must be non-negative integers")
  }

  #Compute target paths
  mpaths(destination = target)*mpaths(c(i - ti, j - tj))

}
