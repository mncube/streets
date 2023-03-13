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
