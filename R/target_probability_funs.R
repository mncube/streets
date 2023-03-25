#' Target Paths Probability Mass Function
#'
#' A probability mass function where the number of target paths through the
#' target location specified in the target parameter is the event of interest and
#' the sum of target paths across all coordinates on the grid is the sample space.
#'
#' If a path passing through a coordinate represents an impression, then dtpaths
#' is the proportion of impressions obtained from the target location after a one
#' traversal of each unique Manhattan Path from the origin to the destination.
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param target A vector defining the target location's coordinates in terms of
#' a horizontal coordinate ti and a vertical coordinate tj.
#'
#' @return A real number in the closed interval 0 to 1
#' @export
#'
#' @examples
#' dtpaths(c(2,2), c(2,1))
dtpaths <- function(destination = c(i, j),
                    target = c(ti, tj)){
  # Get values
  i <- destination[[1]]
  j <- destination[[2]]
  ti <- target[[1]]
  tj <- target[[2]]

  # Count the sum of target paths through each possible target location on the
  #grid
  all_t_paths <- 0
  for (x in 0:i){
    for(y in 0:j){
      all_t_paths <- all_t_paths + tpaths(destination = destination,
                                          target = c(x,y))
    }
  }

  # Compute the probability of the target location
  tpaths(destination = destination,
         target = target)/all_t_paths


}


#' Target Paths Cumulative Distribution Function
#'
#' A cumulative distribution function for the dtpaths probability mass function
#'
#' If a path passing through a coordinate represents an impression, then ptpaths
#' is the proportion of impressions obtained from the coordinates i <= ti &
#' j <= tj after one traversal of each unique Manhattan Path from the origin to
#' the destination.
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param target A vector defining the target coordinates in terms of a
#' horizontal coordinate ti and a vertical coordinate tj.
#'
#' @return A real number in the closed interval 0 to 1
#' @export
#'
#' @examples
#' ptpaths(destination = c(5,5), target = c(1,1))
ptpaths <- function(destination = c(i, j), target = c(ti, tj)) {
  # Get values
  i <- destination[[1]]
  j <- destination[[2]]
  ti <- target[[1]]
  tj <- target[[2]]

  # Initialize the cumulative probability
  cumulative_probability <- 0

  # Iterate through all possible target coordinates up to and including (ti, tj)
  for (x in 0:ti) {
    for (y in 0:tj) {
      # Add the probability of each target coordinate to the cumulative probability
      cumulative_probability <- cumulative_probability + dtpaths(destination = destination, target = c(x, y))
    }
  }

  # Return the cumulative probability
  return(cumulative_probability)
}

#' Target Paths Quantile Function
#'
#' A quantile function which takes a probability p and a destination (i, j) as
#' inputs and returns the coordinates for the target location (ti, tj) where the
#' cumulative probability is equal to or greater than p. The target location
#' generated has the smallest cumulative probability >= p; if multiple coordinates
#' are tied, then the target location with closest Manhattan Distance to the origin
#' will be selected, and if there are still ties, then the wise parameter will
#' be used to break ties.
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param p a probability
#' @param wise col selects lowest coordinates by j then i while row selects lowest
#' by i then j
#'
#' @return coordinates for a target location
#' @export
#'
#' @examples
#' qtpaths(c(5,5), .5)
qtpaths <- function(destination = c(i, j), p, wise = "col") {
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

  # Step 1: Get a list of all target coordinates with ptpaths >= p
  coords <- list()
  for (ti in 0:i) {
    for (tj in 0:j) {
      if (ptpaths(destination = destination, target = c(ti, tj)) >= p) {
        coords <- append(coords, list(c(ti, tj)))
      }
    }
  }

  # Step 2: Filter the list to remove all target coordinates where ptpaths does not equal min(ptpaths)
  min_ptpaths <- min(sapply(coords, function(coord) ptpaths(destination = destination, target = coord)))
  coords <- Filter(function(coord) ptpaths(destination = destination, target = coord) == min_ptpaths, coords)

  # Step 3: Filter the list to remove all target coordinates where the Manhattan Distance from the origin to the coordinate is not the min(Manhattan Distance from the origin to the coordinate)
  manhattan_distance <- function(coord) sum(abs(coord))
  min_distance <- min(sapply(coords, manhattan_distance))
  coords <- Filter(function(coord) manhattan_distance(coord) == min_distance, coords)

  # Step 4: If there are still ties, then use wise to select the target coordinate
  if (length(coords) > 1) {
    if (wise == "col") {
      coords <- coords[order(sapply(coords, function(coord) coord[2]), sapply(coords, function(coord) coord[1]))]
    } else {
      coords <- coords[order(sapply(coords, function(coord) coord[1]), sapply(coords, function(coord) coord[2]))]
    }
  }


  # Return the target coordinate (ti, tj)
  return(coords[[1]])
}


#' Target Paths Random Variable Function
#'
#' A random variable function that generates random target coordinates from the
#' distribution defined by the dtpaths probability mass function.
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param n The number of target coordinates to generate
#'
#' @return A matrix of target coordinates
#' @export
#'
#' @examples
#' rtpaths(c(10,10), 2)
rtpaths <- function(destination = c(i, j), n = 1) {
  # Get values
  i <- destination[[1]]
  j <- destination[[2]]

  # Create an array of all possible target coordinates
  all_targets <- expand.grid(ti = 0:i, tj = 0:j)

  # Compute the probabilities for each target coordinate
  all_probs <- apply(all_targets, 1, function(x) dtpaths(destination, target = x))

  # Normalize the probabilities (to account for potential floating-point errors)
  all_probs <- all_probs / sum(all_probs)

  # Sample target coordinates based on their probabilities
  sampled_indices <- sample(1:(length(all_probs)), size = n, replace = TRUE, prob = all_probs)
  sampled_targets <- all_targets[sampled_indices, ]

  # Return the matrix of random target coordinates
  return(sampled_targets)
}
