tpaths <- function(destination = c(i,j), target = c(ti, tj)){

  #Get values
  i <- destination[[1]]
  j <- destination[[2]]
  ti <- target[[1]]
  tj <- target[[2]]

  if (ti > i | tj < j){
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
  mpaths(ti, tj)*mpaths(i - ti, j - tj)

}
