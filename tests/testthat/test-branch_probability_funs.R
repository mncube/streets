test_that("dbpaths is working as expected", {
  #Test 1 dbpaths sums to 1 across all points on grid
  expect_equal(sum(dbpaths(c(2,2), c(0,0)),
                   dbpaths(c(2,2), c(0,1)),
                   dbpaths(c(2,2), c(1,0)),
                   dbpaths(c(2,2), c(1,1)),
                   dbpaths(c(2,2), c(1,2)),
                   dbpaths(c(2,2), c(2,1)),
                   dbpaths(c(2,2), c(2,2)),
                   dbpaths(c(2,2), c(0,2)),
                   dbpaths(c(2,2), c(2,0))), 1)

  #Test 2 dbpaths sums to 1 across all points on grid
  cumpaths <- 0
  for (x in 0:10){
    for (y in 0:10){
      cumpaths <- cumpaths + dbpaths(c(10,10), c(x,y))
    }
  }
  expect_equal(cumpaths, 1)
})


test_that("pbpaths returns correct values and behaves as expected", {
  # Test 1: When the target is the origin (0, 0)
  expect_equal(pbpaths(c(3, 3), c(0, 0)), dbpaths(c(3, 3), c(0, 0)))

  # Test 2: When the target is the destination (i, j)
  expect_equal(pbpaths(c(3, 3), c(3, 3)), 1)

  # Test 3: Cumulative probability function is symmetric
  expect_equal(pbpaths(c(3, 3), c(2, 1)), pbpaths(c(3, 3), c(1, 2)))
  expect_equal(pbpaths(c(10, 10), c(3, 8)), pbpaths(c(10, 10), c(8, 3)))

  # Test 4: When the target coordinate is off the grid
  expect_error(pbpaths(c(3, 3), c(4, 3)), "Branch coordinate must be on grid")
  expect_error(pbpaths(c(3, 3), c(3, 4)), "Branch coordinate must be on grid")
})
