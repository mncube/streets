test_that("ddpaths returns correct values and behaves as expected", {

  #Test 1 ddpaths sums to 1 across all points on grid
  expect_equal(sum(ddpaths(c(2,2), c(0,0)),
                   ddpaths(c(2,2), c(0,1)),
                   ddpaths(c(2,2), c(1,0)),
                   ddpaths(c(2,2), c(1,1)),
                   ddpaths(c(2,2), c(1,2)),
                   ddpaths(c(2,2), c(2,1)),
                   ddpaths(c(2,2), c(2,2)),
                   ddpaths(c(2,2), c(0,2)),
                   ddpaths(c(2,2), c(2,0))), 1)

  #Test 2 ddpaths sums to 1 across all points on grid
  cumpaths <- 0
  for (x in 0:10){
    for (y in 0:10){
      cumpaths <- cumpaths + ddpaths(c(10,10), c(x,y))
    }
  }
  expect_equal(cumpaths, 1)

  #Test 3 ddpaths equals 0 when detour is at origin
  expect_equal(ddpaths(c(5,5), c(0,0)), 0)

  #Test 4 ddpaths equals 0 when detour is at destination
  expect_equal(ddpaths(c(5,5), c(5,5)), 0)

  #Test 5 ddpaths is symmetric
  expect_equal(ddpaths(c(100,100), c(63,29)), ddpaths(c(100,100), c(29,63)))

})


test_that("pdpaths returns correct values and behaves as expected", {
  # Test 1: When the target is the origin (0, 0)
  expect_equal(pdpaths(c(3, 3), c(0, 0)), ddpaths(c(3, 3), c(0, 0)))

  # Test 2: When the target is the destination (i, j)
  expect_equal(pdpaths(c(3, 3), c(3, 3)), 1)

  # Test 3: Cumulative probability function is symmetric
  expect_equal(pdpaths(c(3, 3), c(2, 1)), pdpaths(c(3, 3), c(1, 2)))
  expect_equal(pdpaths(c(10, 10), c(3, 8)), pdpaths(c(10, 10), c(8, 3)))

  # Test 4: When the target coordinate is off the grid
  expect_error(pdpaths(c(3, 3), c(4, 3)), "Detour coordinate must be on grid.")
  expect_error(pdpaths(c(3, 3), c(3, 4)), "Detour coordinate must be on grid.")
})


test_that("qdpaths returns correct values and behaves as expected", {
  destination <- c(3, 3)

  # Test 1: Check that qdpaths returns the origin (0, 0) for p = 0
  expect_equal(qdpaths(destination, p = 0), c(0, 0))

  # Test 2: Check that qdpaths returns the destination (i, j) for p = 1
  expect_equal(qdpaths(destination, p = 1), destination)

  # Test 3: Test qdpaths against known cumulative probabilities
  detour1 <- qdpaths(destination, p = 0.25)
  detour2 <- qdpaths(destination, p = 0.5)
  detour3 <- qdpaths(destination, p = 0.75)
  expect_true(pdpaths(destination, detour1) >= 0.25)
  expect_true(pdpaths(destination, detour2) >= 0.5)
  expect_true(pdpaths(destination, detour3) >= 0.75)

  # Test 4: Check that qdpaths raises an error for p < 0 or p > 1
  expect_error(qdpaths(destination, p = -0.1), "p must be between 0 and 1")
  expect_error(qdpaths(destination, p = 1.1), "p must be between 0 and 1")
})

