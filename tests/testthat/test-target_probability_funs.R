test_that("ptpaths returns correct values and behaves as expected", {
  # Test 1: When the target is the origin (0, 0)
  expect_equal(ptpaths(c(3, 3), c(0, 0)), dtpaths(c(3, 3), c(0, 0)))

  # Test 2: When the target is the destination (i, j)
  expect_equal(ptpaths(c(3, 3), c(3, 3)), 1)

  # Test 3: Cumulative probability function is symmetric
  expect_equal(ptpaths(c(3, 3), c(2, 1)), ptpaths(c(3, 3), c(1, 2)))
  expect_equal(ptpaths(c(10, 10), c(3, 8)), ptpaths(c(10, 10), c(8, 3)))

  # Test 4: When the target coordinate is off the grid
  expect_error(ptpaths(c(3, 3), c(4, 3)), "Target coordinate must be on grid")
  expect_error(ptpaths(c(3, 3), c(3, 4)), "Target coordinate must be on grid")
})


test_that("dtpaths returns correct values and behaves as expected", {
  expect_equal(sum(dtpaths(c(2,2), c(0,0)),
                   dtpaths(c(2,2), c(0,1)),
                   dtpaths(c(2,2), c(1,0)),
                   dtpaths(c(2,2), c(1,1)),
                   dtpaths(c(2,2), c(1,2)),
                   dtpaths(c(2,2), c(2,1)),
                   dtpaths(c(2,2), c(2,2)),
                   dtpaths(c(2,2), c(0,2)),
                   dtpaths(c(2,2), c(2,0))), 1)

  cumpaths <- 0
  for (x in 0:10){
    for (y in 0:10){
      cumpaths <- cumpaths + dtpaths(c(10,10), c(x,y))
    }
  }
  expect_equal(cumpaths, 1)
})


test_that("qtpaths returns correct values and behaves as expected", {
  destination <- c(3, 3)

  # Test 1: Check that qtpaths returns the origin (0, 0) for p = 0
  expect_equal(qtpaths(destination, p = 0), c(0, 0))

  # Test 2: Check that qtpaths returns the destination (i, j) for p = 1
  expect_equal(qtpaths(destination, p = 1), destination)

  # Test 3: Test qtpaths against known cumulative probabilities
  target1 <- qtpaths(destination, p = 0.25)
  target2 <- qtpaths(destination, p = 0.5)
  target3 <- qtpaths(destination, p = 0.75)
  expect_true(ptpaths(destination, target1) >= 0.25)
  expect_true(ptpaths(destination, target2) >= 0.5)
  expect_true(ptpaths(destination, target3) >= 0.75)

  # Test 4: Check that qtpaths raises an error for p < 0 or p > 1
  expect_error(qtpaths(destination, p = -0.1), "p must be between 0 and 1")
  expect_error(qtpaths(destination, p = 1.1), "p must be between 0 and 1")
})
