#' Detour Paths Probability Mass Function
#'
#' A probability mass function where the number of detour paths through the
#' detour location specified in the detour parameter is the event of interest and
#' the sum of detour paths across all coordinates on the grid is the sample space.
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param detour A vector defining the detour location's coordinates in terms of
#' a horizontal coordinate ti and a vertical coordinate tj.
#'
#' @return A real number in the closed interval 0 to 1
#' @export
#'
#' @examples
#' ddpaths(c(2,2), c(2,1))
ddpaths <- function(destination = c(i, j),
                    detour = c(di, dj)){
  # Get values
  i <- destination[[1]]
  j <- destination[[2]]
  di <- detour[[1]]
  dj <- detour[[2]]

  # Count the sum of detour paths around each possible detour location on the
  #grid
  all_d_paths <- 0
  for (x in 0:i){
    for(y in 0:j){
      all_d_paths <- all_d_paths + dpaths(destination = destination,
                                          detour = c(x,y))
    }
  }

  # Compute the probability of the detour location
  dpaths(destination = destination,
         detour = detour)/all_d_paths
}


#' Detour Paths Cumulative Distribution Function
#'
#' A cumulative distribution function for the ddpaths probability mass function
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param detour A vector defining the detour coordinates in terms of a
#' horizontal coordinate ti and a vertical coordinate tj.
#'
#' @return A real number in the closed interval 0 to 1
#' @export
#'
#' @examples
#' pdpaths(destination = c(5,5), detour = c(1,1))
pdpaths <- function(destination = c(i, j), detour = c(di, dj)) {
  # Get values
  i <- destination[[1]]
  j <- destination[[2]]
  di <- detour[[1]]
  dj <- detour[[2]]

  # Initialize the cumulative probability
  cumulative_probability <- 0

  # Iterate through all possible detour coordinates up to and including (di, dj)
  for (x in 0:di) {
    for (y in 0:dj) {
      # Add the probability of each detour coordinate to the cumulative probability
      cumulative_probability <- cumulative_probability + ddpaths(destination = destination, detour = c(x, y))
    }
  }

  # Return the cumulative probability
  return(cumulative_probability)
}


#' Detour Paths Quantile Function
#'
#' A quantile function which takes a probability p and a destination (i, j) as
#' inputs and returns the coordinates for the detour location (di, dj) where the
#' cumulative probability is equal to or just greater than p.
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param p a probability
#' @param wise when generating quantiles, col uses j (i.e., columns) for the
#' inner loop and i for the outer loop while row uses i for the inner loop
#' and j for the outer loop.
#'
#' @return coordinates for a detour location
#' @export
#'
#' @examples
#' qdpaths(c(5,5), .5)
qdpaths <- function(destination = c(i, j), p, wise = "col") {
  # Get values
  i <- destination[[1]]
  j <- destination[[2]]

  # Check if p is within the valid range [0, 1]
  if (p < 0 || p > 1) {
    rlang::abort(message = "p must be between 0 and 1")
  }


  # Iterate through all possible detour coordinates

  # Check if wise is a valid value
  if (!(wise == "col" | wise == "row")){
    rlang::abort(message ="wise must be set to 'col' or 'row'")
  }

  if (wise == "col"){
    for (di in 0:i) {
      for (dj in 0:j) {
        # Check if the cumulative probability at (di, dj) is equal to or just
        #greater than p
        if (pdpaths(destination = destination, detour = c(di, dj)) >= p) {
          # Return the detour coordinate (di, dj)
          return(c(di,dj))
        }
      }
    }
  } else {
    for (dj in 0:j) {
      for (di in 0:i) {
        # Check if the cumulative probability at (di, dj) is equal to or just
        #greater than p
        if (pdpaths(destination = destination, detour = c(di, dj)) >= p) {
          # Return the detour coordinate (di, dj)
          return(c(di,dj))
        }
      }
    }
  }

  # In case no suitable detour coordinate is found (should not happen with valid
  #inputs)
  rlang::abort(message = "No suitable detour coordinate found")

}


#' Detour Paths Random Variable Function
#'
#' A random variable function that generates random detour coordinates from the
#' distribution defined by the ddpaths probability mass function.
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param n The number of detour coordinates to generate
#'
#' @return A matrix of detour coordinates
#' @export
#'
#' @examples
#' rdpaths(c(10,10), 2)
rdpaths <- function(destination = c(i, j), n = 1) {
  # Get values
  i <- destination[[1]]
  j <- destination[[2]]

  # Create an array of all possible detour coordinates
  all_detours <- expand.grid(di = 0:i, dj = 0:j)

  # Compute the probabilities for each detour coordinate
  all_probs <- apply(all_detours, 1, function(x) ddpaths(destination, detour = x))

  # Normalize the probabilities (to account for potential floating-point errors)
  all_probs <- all_probs / sum(all_probs)

  # Sample detour coordinates based on their probabilities
  sampled_indices <- sample(1:(length(all_probs)), size = n, replace = TRUE, prob = all_probs)
  sampled_detours<- all_detours[sampled_indices, ]

  # Return the matrix of random detour coordinates
  return(sampled_detours)
}
