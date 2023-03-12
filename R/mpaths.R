#' Manhattan Paths
#'
#' The mpaths function computes the number of paths with equal Manhattan Distance
#' starting at the origin (0,0) and ending at (i, j).
#'
#' @param i number of rows in the 2D lattice
#' @param j number of columns in the 2D lattice
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

  factorial(i+j)/(factorial(i)*factorial(j))
}
