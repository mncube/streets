#' Target Paths Cumulative Distribution Function
#'
#' A cumulative distribution function for the dtpaths probability mass function
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

# ptpaths <- function(destination = c(i, j),
#                    target = c(ti, tj)){
#   #Get values
#   i <- destination[[1]]
#   j <- destination[[2]]
#   ti <- target[[1]]
#   tj <- target[[2]]
#
#   tpaths(destination = destination,
#          target = target)/mpaths(destination = destination)
# }


#' Target Paths Probability Mass Function
#'
#' A probability mass function where the number of target paths through the
#' target location specified in the target parameter is the event of interest and
#' the sum of target paths across all coordinates on the grid is the sample space.
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


#' Target Paths Quantile Function
#'
#' A quantile function which takes a probability p and a destination (i, j) as
#' inputs and returns the coordinates for the target location (ti, tj) where the
#' cumulative probability is equal to or just greater than p.
#'
#' @param destination A vector defining the destination coordinates in terms of
#' a horizontal coordinate i and a vertical coordinate j.
#' @param p a probability
#' @param wise when generating quantiles, colwise uses j (i.e., columns) for the
#' inner loop and i for the outer loop while rowwise uses i for the inner loop
#' and j for the outer loop.
#'
#' @return coordinates for a target location
#' @export
#'
#' @examples
#' qtpaths(c(5,5), .5)
qtpaths <- function(destination = c(i, j), p, wise = "colwise") {
  # Get values
  i <- destination[[1]]
  j <- destination[[2]]

  # Check if p is within the valid range [0, 1]
  if (p < 0 || p > 1) {
    rlang::abort(message = "p must be between 0 and 1")
  }


  # Iterate through all possible target coordinates

  # Check if wise is a valid value
  if (!(wise == "colwise" | wise == "rowwise")){
    rlang::abort(message ="wise must be set to colwise or rowwise")
  }

  if (wise == "colwise"){
    for (ti in 0:i) {
      for (tj in 0:j) {
        # Check if the cumulative probability at (ti, tj) is equal to or just greater than p
        if (ptpaths(destination = destination, target = c(ti, tj)) >= p) {
          # Return the target coordinate (ti, tj)
          return(c(ti,tj))
        }
      }
    }
  } else {
    for (tj in 0:j) {
      for (ti in 0:i) {
        # Check if the cumulative probability at (ti, tj) is equal to or just greater than p
        if (ptpaths(destination = destination, target = c(ti, tj)) >= p) {
          # Return the target coordinate (ti, tj)
          return(c(ti,tj))
        }
      }
    }
  }

  # In case no suitable target coordinate is found (should not happen with valid inputs)
    rlang::abort(message = "No suitable target coordinate found")

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


# rtpaths <- function(destination = c(i, j), n = 1) {
#   # Get values
#   i <- destination[[1]]
#   j <- destination[[2]]
#
#   # Initialize an empty matrix to store the generated target coordinates
#   random_targets <- matrix(0, nrow = n, ncol = 2)
#
#   # Generate n random target coordinates
#   for (k in 1:n) {
#     # Generate a random probability value between 0 and 1
#     p <- stats::runif(1)
#
#     # Use the qtpaths function to get the corresponding target coordinate for the random probability value
#     random_target <- qtpaths(destination = destination, p = p)
#
#     # Add the generated target coordinate to the random_targets matrix
#     random_targets[k, ] <- random_target
#   }
#
#   # Return the random_targets matrix
#   return(random_targets)
# }
