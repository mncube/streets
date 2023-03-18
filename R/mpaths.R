#' Manhattan Paths
#'
#' The mpaths function computes the number of paths with equal Manhattan Distance
#' starting at the origin (0,0) and ending at (i, j).  For more information on
#' Manhattan Distance see Chartrand et. al. (2020) Result 19.5 and Blitzstein &
#' Hwang (2019) Excercises 1.9 #9
#'
#' @references
#' Chartrand, G., Polimeni, A. D., & Zhang, P. (2020). Mathematical proofs: A
#' transition to advanced mathematics (4th ed.). Pearson.
#'
#' @references
#' Blitzstein, J., & Hwang, J. (2019). Introduction to probability (2nd ed.). CRC Press.
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
