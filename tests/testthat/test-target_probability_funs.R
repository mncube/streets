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

