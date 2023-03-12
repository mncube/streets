mpaths <- function(i,j){

  if (i < 0 | j < 0){
    rlang::abort(message = "i and j must be non-negative.")
  }

  if (i != floor(i) | j != floor(j)){
    rlang::abort(message = "i and j must be natural numbers")
  }

  factorial(i+j)/(factorial(i)*factorial(j))
}
