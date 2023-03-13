dpaths <- function(destination = c(i,j), detour = c(di, dj)){
  i <- destination[[1]]
  j <- destination[[2]]
  di <- detour[[1]]
  dj <- detour[[2]]

  #Compute detour paths
  mpaths(i,j) - tpaths(destination = destination, target = detour)
}
