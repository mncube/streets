#' Detour Paths
#'
#' The dpaths function computes the number of paths with equal Manhattan Distance
#' starting at the origin (0,0) NOT passing through the detour coordinate (di, dj) and
#' ending at the destination (i, j).
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j
#'
#' @param detour A vector defining the detour coordinates in terms of a horizontal
#' coordinate di and a vertical coordinate dj
#'
#' @return A number
#' @export
#'
#' @examples
#' dpaths(destination = c(4,4), detour = c(2,2))
dpaths <- function(destination = c(i,j), detour = c(di, dj)){

  # Get values
  i <- destination[[1]]
  j <- destination[[2]]
  di <- detour[[1]]
  dj <- detour[[2]]

  if (di > i | dj > j){
    rlang::abort(message = "Detour coordinate must be on grid.  Make sure i >= di and
                 j >= dj.")
  }

  if (di < 0 | dj < 0){
    rlang::abort(message = "di and dj must be non-negative.")
  }

  if (di != floor(di) | dj != floor(dj)){
    rlang::abort(message = "di and dj must be non-negative integers")
  }

  #Compute detour paths
  mpaths(i,j) - tpaths(destination = destination, target = detour)
}
