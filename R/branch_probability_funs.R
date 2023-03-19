#' Branch Paths Probability Mass Function
#'
#' A probability mass function where the number of branch paths through the
#' branch location specified in the branch parameter is the event of interest and
#' the sum of branch paths across all coordinates on the grid is the sample space.
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param branch A vector defining the branch location's coordinates in terms of
#' a horizontal coordinate bi and a vertical coordinate bj.
#'
#' @return A real number in the closed interval 0 to 1
#' @export
#'
#' @examples
#' dbpaths(c(2,2), c(2,1))
dbpaths <- function(destination = c(i, j),
                    branch = c(bi, bj)){
  # Get values
  i <- destination[[1]]
  j <- destination[[2]]
  bi <- branch[[1]]
  bj <- branch[[2]]

  # Count the sum of branch paths through each possible branch location on the
  #grid
  all_b_paths <- 0
  for (x in 0:i){
    for(y in 0:j){
      all_b_paths <- all_b_paths + bpaths(destination = destination,
                                          branch = c(x,y))
    }
  }

  # Compute the probability of the target location
  bpaths(destination = destination,
         branch = branch)/all_b_paths
}


#' Branch Paths Cumulative Distribution Function
#'
#' A cumulative distribution function for the dbpaths probability mass function
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param branch A vector defining the branch coordinates in terms of a
#' horizontal coordinate bi and a vertical coordinate bj.
#'
#' @return A real number in the closed interval 0 to 1
#' @export
#'
#' @examples
#' pbpaths(destination = c(5,5), branch = c(1,1))
pbpaths <- function(destination = c(i, j), branch = c(bi, bj)) {
  # Get values
  i <- destination[[1]]
  j <- destination[[2]]
  bi <- branch[[1]]
  bj <- branch[[2]]

  # Initialize the cumulative probability
  cumulative_probability <- 0

  # Iterate through all possible branch coordinates up to and including (bi, bj)
  for (x in 0:bi) {
    for (y in 0:bj) {
      # Add the probability of each branch coordinate to the cumulative probability
      cumulative_probability <- cumulative_probability +
        dbpaths(destination = destination, branch = c(x, y))
    }
  }

  # Return the cumulative probability
  return(cumulative_probability)
}


#' Branch Paths Quantile Function
#'
#' A quantile function which takes a probability p and a destination (i, j) as
#' inputs and returns the coordinates for the branch location (bi, bj) where the
#' cumulative probability is equal to or greater than p. The branch location
#' generated has the smallest cumulative probability >= p; if multiple coordinates
#' are tied, then the branch location with closest Manhattan Distance to the origin
#' will be selected, and if there are still ties, then the wise parameter will
#' be used to break ties.
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param p a probability
#' @param wise col selects lowest coordinates by j then i while row selects lowest
#' by i then j
#'
#' @return coordinates for a branch location
#' @export
#'
#' @examples
#' qbpaths(c(5,5), .5)
qbpaths <- function(destination = c(i, j), p, wise = "col") {
  # Get values
  i <- destination[[1]]
  j <- destination[[2]]

  # Check if p is within the valid range [0, 1]
  if (p < 0 || p > 1) {
    rlang::abort(message = "p must be between 0 and 1")
  }

  # Check if wise is a valid value
  if (!(wise == "col" | wise == "row")){
    rlang::abort(message ="wise must be set to 'col' or 'row'")
  }

  # Step 1: Get a list of all branch coordinates with pbpaths >= p
  coords <- list()
  for (bi in 0:i) {
    for (bj in 0:j) {
      if (pbpaths(destination = destination, branch = c(bi, bj)) >= p) {
        coords <- append(coords, list(c(bi, bj)))
      }
    }
  }

  # Step 2: Filter the list to remove all branch coordinates where pbpaths does not equal min(pbpaths)
  min_pbpaths <- min(sapply(coords, function(coord) pbpaths(destination = destination, branch = coord)))
  coords <- Filter(function(coord) pbpaths(destination = destination, branch = coord) == min_pbpaths, coords)

  # Step 3: Filter the list to remove all branch coordinates where the Manhattan Distance from the origin to the coordinate is not the min(Manhattan Distance from the origin to the coordinate)
  manhattan_distance <- function(coord) sum(abs(coord))
  min_distance <- min(sapply(coords, manhattan_distance))
  coords <- Filter(function(coord) manhattan_distance(coord) == min_distance, coords)

  # Step 4: If there are still ties, then use wise to select the branch coordinate
  if (length(coords) > 1) {
    if (wise == "col") {
      coords <- coords[order(sapply(coords, function(coord) coord[2]), sapply(coords, function(coord) coord[1]))]
    } else {
      coords <- coords[order(sapply(coords, function(coord) coord[1]), sapply(coords, function(coord) coord[2]))]
    }
  }


  # Return the branch coordinate (bi, bj)
  return(coords[[1]])
}


#' Branch Paths Random Variable Function
#'
#' A random variable function that generates random branch coordinates from the
#' distribution defined by the dbpaths probability mass function.
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param n The number of branch coordinates to generate
#'
#' @return A matrix of branch coordinates
#' @export
#'
#' @examples
#' rbpaths(c(10,10), 2)
rbpaths <- function(destination = c(i, j), n = 1) {
  # Get values
  i <- destination[[1]]
  j <- destination[[2]]

  # Create an array of all possible branch coordinates
  all_branchs <- expand.grid(bi = 0:i, bj = 0:j)

  # Compute the probabilities for each branch coordinate
  all_probs <- apply(all_branchs, 1, function(x) dbpaths(destination, branch = x))

  # Normalize the probabilities (to account for potential floating-point errors)
  all_probs <- all_probs / sum(all_probs)

  # Sample branch coordinates based on their probabilities
  sampled_indices <- sample(1:(length(all_probs)), size = n, replace = TRUE, prob = all_probs)
  sampled_branchs <- all_branchs[sampled_indices, ]

  # Return the matrix of random branch coordinates
  return(sampled_branchs)
}
