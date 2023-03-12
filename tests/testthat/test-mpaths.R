test_that("mpaths gives expected value for (5,5) grid", {
  #(5 + 5)!/(5!*5!)=(10*9*8*7*6)/(5*4*3*2*1)=2*3*2*7*3
  expect_equal(mpaths(5,5), 2*3*2*7*3)
})


test_that("mpaths and choose give same answer for allowed values", {

  # Get random coordinates
  i <- floor(stats::rnorm(1, 100, 50))
  j <- floor(stats::rnorm(1, 50, 10))

  # Check that coordinates are legal
  if (i < 0) i <- 0
  if (j < 0) j <- 0

  expect_equal(mpaths(i = i,j = j), choose(n = i + j, k = j))
})


test_that("unallowed input produces error", {
  expect_error(mpaths(-1,4))
  expect_error(mpaths(2.3,5))
})
