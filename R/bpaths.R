#' Branch Paths
#'
#' The bpaths function computes the number of paths starting at the origin (0,0)
#' passing through the branch coordinate (bi, bj) and ending at the destination
#' (i, j).  At non-branch coordinates, the path is only allowed to step upwards
#' and rightwards; however, at the branch coordinate, the path is allowed to step
#' in any direction except the direction in which the path entered the branch
#' coordinate.  This is similar to a no-U turn intersection where a car can go
#' straight, turn left, or turn right.
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j
#' @param branch  A vector defining the branch coordinates in terms of a horizontal
#' coordinate bi and a vertical coordinate bj
#'
#' @return A number
#' @export
#'
#' @examples
#' bpaths(c(3,3), c(2,2))
bpaths <- function(destination = c(i,j), branch = c(bi, bj)){

  #Get values
  i <- destination[[1]]
  j <- destination[[2]]
  bi <- branch[[1]]
  bj <- branch[[2]]

  if (bi > i | bj > j){
    rlang::abort(message = "Branch coordinate must be on grid.  Make sure i >= bi and
                 j >= bj.")
  }

  if (bi < 0 | bj < 0){
    rlang::abort(message = "bi and bj must be non-negative.")
  }

  if (bi != floor(bi) | bj != floor(bj)){
    rlang::abort(message = "bi and bj must be non-negative integers")
  }

  #Compute branch paths
  if (bi == 0 || bj == 0){
    tpaths(destination = destination, target = branch)
  } else if (bi == i && bj == j){
    mpaths(destination = destination)
  }else if (bi == i){
    mpaths(c(bi, bj-1))*(mpaths(c(i-bi, j-bj)) + mpaths(c(i -(bi-1), j-(bj+1)))) +
      mpaths(c(bi-1,bj))*mpaths(c(i-bi,j-bj))
  } else if (bj==j) {
    mpaths(c(bi, bj-1))*mpaths(c(i-bi, j-bj)) +
      mpaths(c(bi-1,bj))*(mpaths(c(i-bi,j-bj)) + mpaths(c(i-(bi+1), j-(bj-1))))
  }else {
    mpaths(c(bi, bj-1))*(mpaths(c(i-bi, j-bj)) + mpaths(c(i -(bi-1), j-(bj+1)))) +
      mpaths(c(bi-1,bj))*(mpaths(c(i-bi,j-bj)) + mpaths(c(i-(bi+1), j-(bj-1))))
  }

}
