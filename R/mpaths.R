#' Manhattan Paths
#'
#' The mpaths function computes the number of paths with equal Manhattan Distance
#' starting at the origin (0,0) and ending at (i, j).
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j
#'
#' @return A number
#' @export
#'
#' @examples
#' mpaths(c(2,2))
mpaths <- function(destination = c(i,j)){

  #Get values
  i <- destination[[1]]
  j <- destination[[2]]

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
