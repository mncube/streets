#' Target Location Probability Mass Function
#'
#' A probability mass function where the number of Target Paths (with a target
#' location defined with the targer parameter) is the event of interest and the
#' number of Manhattan Paths (on a grid defined with the destination parameter)
#' is the sample space.
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
#' pftarg(destination = c(5,5), target = c(1,1))
pftarg <- function(destination = c(i, j),
                   target = c(ti, tj)){
  #Get values
  i <- destination[[1]]
  j <- destination[[2]]
  ti <- target[[1]]
  tj <- target[[2]]

  tpaths(destination = destination,
         target = target)/mpaths(destination = destination)
}

# ptarg <- function(destination = c(i, j),
#                   target = c(ti, tj)){
#
#   #Get values
#   i <- destination[[1]]
#   j <- destination[[2]]
#   ti <- target[[1]]
#   tj <- target[[2]]
#
#   length(0:ti)*length(0:tj)
#
#   sum(my_pmf(1:x))
#   sum(pftarg)
#   integrate(pftarg, -Inf, destination, target)$value
#
# }


# ptarg <- function(destination = c(i, j), target = c(ti, tj), x){
#
#   #Might need to evaluate at all points and grid and get proportion of points
#   #with less paths than at the target point.
#
#   #Get values
#   i <- destination[[1]]
#   j <- destination[[2]]
#   ti <- target[[1]]
#   tj <- target[[2]]
#
#   #Calculate cumulative probability
#   cum_prob <- 0
#   for (k in 0:x){
#     cum_prob <- cum_prob + pftarg(destination, target = c(ti + k, tj + x - k))
#   }
#
#   return(cum_prob)
# }
#
#
# # ptarg <- function(destination = c(i, j), target = c(ti, tj)){
# #
# #   #Get values
# #   i <- destination[[1]]
# #   j <- destination[[2]]
# #   ti <- target[[1]]
# #   tj <- target[[2]]
# #
# #   #Calculate cumulative probability
# #   cum_prob <- 0
# #   for (iti in 0:ti){
# #     for(itj in 0:tj){
# #       cum_prob <- cum_prob + pftarg(destination, target = c(iti, itj))
# #     }
# #   }
# #
# #   return(cum_prob)
# # }
