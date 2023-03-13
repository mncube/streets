#' Manhattan Paths
#'
#' The mpaths function computes the number of paths with equal Manhattan Distance
#' starting at the origin (0,0) and ending at (i, j).
#'
#' @param i horizontal coordinate of the 2D lattice
#' @param j vertical coordinate of the 2D lattice
#'
#' @return A number
#' @export
#'
#' @examples
#' mpaths(i = 2, j = 2)
mpaths <- function(i,j){

  if (i < 0 | j < 0){
    rlang::abort(message = "i and j must be non-negative.")
  }

  if (i != floor(i) | j != floor(j)){
    rlang::abort(message = "i and j must be non-negative integers")
  }

  #factorial(i+j)/(factorial(i)*factorial(j))
  #Note: Use choose instead of factorial to avoid NaNs
  choose(i + j, j)
}
